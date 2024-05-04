from langchain import hub
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnablePassthrough, RunnableLambda
from langchain_openai import ChatOpenAI
from tavily import TavilyClient
from llm.prompt import casual_prompt, is_qna_prompt, combine_result_prompt, score_prompt
from langchain.retrievers.multi_query import MultiQueryRetriever
import deepl
import os

class LLM_RAG:
    def __init__(self, trace = False):
        self.result = ''
        self.question = ''
        self.llm = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0)
        self.tavily = TavilyClient(os.getenv('TAVILY_API_KEY'))
        self.rag_prompt = hub.pull("rlm/rag-prompt")
        self.casual_prompt = casual_prompt()
        self.is_qna_prompt = is_qna_prompt()
        self.combine_result_prompt = combine_result_prompt()
        self.score_prompt = score_prompt()
        self.deepl = deepl.Translator(os.getenv("DEEPL_API_KEY"))
        self.result_lang = None
        self.notice_retriever = None
        self.school_retriever = None
        self.notice_multiquery_retriever = None
        self.school_multiquery_retriever = None


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
            self.notice_multiquery_retriever = MultiQueryRetriever.from_llm(retriever=retriever, llm=self.llm)

        elif data_type == 'school_info':
            self.school_retriever = retriever
            self.school_multiquery_retriever = MultiQueryRetriever.from_llm(retriever=retriever, llm=self.llm)
        else:
            print('Choose valid type!')

    def set_chain(self):
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

        self.notice_rag_chain = (
            {"context": self.notice_multiquery_retriever | self.format_docs,  "question": RunnablePassthrough()}
            | self.rag_prompt
            | self.llm
            | StrOutputParser()
        )
        
        self.schl_info_rag_chain = (
            {"context":  self.school_multiquery_retriever | self.format_docs, "question": RunnablePassthrough()}
            | self.rag_prompt
            | self.llm
            | StrOutputParser()
        )

        self.rag_combine_chain = (
            {"notice_info": self.notice_rag_chain, "school_info": self.schl_info_rag_chain, "question": RunnablePassthrough()}
            | self.combine_result_prompt
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


    def qna_route(self, info):
        if "question" in info["topic"].lower():
            ko_query = self.deepl.translate_text(self.question, target_lang='KO')
            self.result = self.rag_combine_chain.invoke(ko_query)
            score = self.score_chain.invoke({"question" : ko_query, "answer": self.result})
            self.score_invoke_chain.invoke({"score" : score, "question": ko_query})
        
        elif "casual" in info["topic"].lower():
            self.result =  self.casual_answer_chain.invoke(self.question)

        else:
            self.result = self.rag_combine_chain.invoke(self.question)

        
    def score_route(self, info):
        if "good" in info["score"].lower():
            self.result = self.deepl.translate_text(self.result, target_lang=self.result_lang)
            return self.result
        else:
            print('-- google search --')
            content = self.tavily.qna_search(query='국민대학교 ' + self.question)
            self.result = "답을 찾을 수 없어서 구글에 검색했습니다.\n\n" + content
            self.result = self.deepl.translate_text(self.result, target_lang=self.result_lang)

    def format_docs(self, docs):
    # 검색한 문서 결과를 하나의 문단으로 합쳐줍니다.
        return "\n\n".join(doc.page_content + '\nmetadata=' + str(doc.metadata) for doc in docs)
    
    def query(self, question, result_lang):
        self.question = question
        self.result_lang = result_lang
        self.qna_route_chain.invoke(question)
        return self.result
