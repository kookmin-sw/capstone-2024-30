from langchain import hub
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnablePassthrough, RunnableLambda
from langchain_openai import ChatOpenAI
from tavily import TavilyClient
from llm.prompt import casual_prompt, is_qna_prompt, score_prompt, rag_prompt
from llm.papago import Papago
from langchain.retrievers.multi_query import MultiQueryRetriever
from langchain.retrievers import EnsembleRetriever
from langchain.memory import ChatMessageHistory
from langchain_core.runnables.history import RunnableWithMessageHistory
from langchain_core.chat_history import BaseChatMessageHistory
import os

class LLM_RAG:
    def __init__(self, trace = False):
        self.result = ''
        self.question = ''
        self.llm = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0)
        self.tavily = TavilyClient(os.getenv('TAVILY_API_KEY'))
        self.rag_prompt = rag_prompt()
        self.casual_prompt = casual_prompt()
        self.is_qna_prompt = is_qna_prompt()
        self.score_prompt = score_prompt()
        self.papago = Papago()
        self.ko_query = None
        self.result_lang = None
        self.notice_retriever = None
        self.school_retriever = None
        self.naver_retriever = None
        self.ensemble_retriever = None

        if trace:
            self.langsmith_trace()
    
    def langsmith_trace(self):
        os.environ["LANGCHAIN_API_KEY"] = os.getenv("LANGCHAIN_API_KEY")
        os.environ["LANGCHAIN_ENDPOINT"] = "https://api.smith.langchain.com"
        os.environ["LANGCHAIN_TRACING_V2"] = "true"
        os.environ["LANGCHAIN_PROJECT"] = "test"

    def set_retriver(self, data_type, retriever):
        if data_type == 'notice':
            self.notice_retriever = retriever

        elif data_type == 'school_info':
            self.school_retriever = retriever

        elif data_type == 'naver':
            self.naver_retriever = retriever

        else:
            print('Choose valid type!')

    def set_chain(self):

        self.ensemble_retriever = EnsembleRetriever(
            retrievers= [self.notice_retriever, self.school_retriever, self.naver_retriever],
            weights=[0.2, 0.3, 0.5])

        self.qna_router = (
            self.is_qna_prompt
            | self.llm
            | StrOutputParser()
        )

        self.qna_route_chain = {"topic": self.qna_router, "question": RunnablePassthrough()} | RunnableLambda(
        self.qna_route # 'causal' or 'question'
        )

        self.casual_answer_chain = (
            {"question": RunnablePassthrough()}
            | self.casual_prompt
            | self.llm
            | StrOutputParser()
        )

        self.rag_chain = (
            {"context": self.ensemble_retriever | self.format_docs,  "question": RunnablePassthrough()}
            | self.rag_prompt
            | self.llm
            | StrOutputParser()
        )

        self.score_chain = (
            self.score_prompt
            | self.llm
            | StrOutputParser()
        )

        self.score_invoke_chain = RunnableLambda(
            self.score_route
        )

        self.translate_chain = (
            self.translate_prompt
            | self.llm
            | StrOutputParser()
        )

    def qna_route(self, info):        
        if "casual" in info["topic"].lower():
            self.result =  self.casual_answer_chain.invoke(self.ko_query)
            self.result = self.papago.translate_text(self.result, target_lang=self.result_lang)

        else: #if "question" in info["topic"].lower():
            self.result = self.rag_chain.invoke(self.ko_query)
            score = self.score_chain.invoke({"question" : self.ko_query, "answer": self.result})
            self.score_invoke_chain.invoke({"score" : score, "question": self.ko_query})

        
    def score_route(self, info):
        if "good" in info["score"].lower():
            self.result = self.papago.translate_text(self.result, target_lang=self.result_lang)
        else:
            #print('-- google search --')
            content = self.tavily.qna_search(query='국민대학교 ' + self.ko_query)
            content = self.papago.translate_text(content, target_lang=self.result_lang)
            base = "I couldn't find the answer, so I searched on Google.\n\n"
            base = self.papago.translate_text(base, target_lang=self.result_lang)
            self.result = base + content

    # def format_docs(self, docs):
    # # 검색한 문서 결과를 하나의 문단으로 합쳐줍니다.
    #     return "\n\n".join(doc.page_content + '\nmetadata=' + str(doc.metadata) for doc in docs)

    def format_docs(self, docs):
    # 검색한 문서 결과를 하나의 문단으로 합쳐줍니다.
        return "\n\n".join(doc.page_content for doc in docs)
    
    def query(self, question, result_lang):
        self.question = question
        self.ko_query = self.papago.translate_text(self.question, target_lang='ko')
        self.result_lang = result_lang
        self.qna_route_chain.invoke(question)
        return self.result