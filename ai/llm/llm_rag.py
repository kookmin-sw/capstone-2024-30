from langchain import hub
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnablePassthrough, RunnableLambda
from langchain_openai import ChatOpenAI
from tavily import TavilyClient
from llm.prompt import casual_prompt, is_qna_prompt, combine_result_prompt, score_prompt, contextualize_prompt
from langchain.retrievers.multi_query import MultiQueryRetriever
from langchain.memory import ChatMessageHistory
from langchain_core.runnables.history import RunnableWithMessageHistory
from langchain_core.chat_history import BaseChatMessageHistory
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
        self.contextualize_prompt = contextualize_prompt()
        self.deepl = deepl.Translator(os.getenv("DEEPL_API_KEY"))
        self.ko_query = None
        self.result_lang = None
        self.notice_retriever = None
        self.school_retriever = None
        self.notice_multiquery_retriever = None
        self.school_multiquery_retriever = None
        self.store = {}
        self.session_id = None
        self.ephemeral_chat_history = ChatMessageHistory()


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

        self.contextualize_question_chain = RunnableWithMessageHistory(
            self.contextualize_prompt
            |self.llm
            |StrOutputParser(),
            self.get_session_history,
            input_messages_key='input',
            history_messages_key='chat_history'
        )


    def qna_route(self, info):
        if self.session_id in self.store.keys():
            self.ko_query = self.contextualize_question_chain.invoke(
                    {"input": self.ko_query},
                    {"configurable": {"session_id": self.session_id}},
                    )
            self.ko_query = self.deepl.translate_text(self.ko_query, target_lang=self.result_lang).text
        else:
            self.store[self.session_id] = ChatMessageHistory()
    
        if "question" in info["topic"].lower():
            self.result = self.rag_combine_chain.invoke(self.ko_query)
            score = self.score_chain.invoke({"question" : self.ko_query, "answer": self.result})
            self.score_invoke_chain.invoke({"score" : score, "question": self.ko_query})
        
        elif "casual" in info["topic"].lower():
            self.result =  self.casual_answer_chain.invoke(self.ko_query)

        else:
            self.result = self.rag_combine_chain.invoke(self.ko_query)

        
    def score_route(self, info):
        if "good" in info["score"].lower():
            self.result = self.deepl.translate_text(self.result, target_lang=self.result_lang).text
        else:
            #print('-- google search --')
            content = self.tavily.qna_search(query='국민대학교 ' + self.ko_query)
            content = self.deepl.translate_text(content, target_lang=self.result_lang).text
            base = "I couldn't find the answer, so I searched on Google.\n\n"
            base = self.deepl.translate_text(base, target_lang=self.result_lang).text
            self.result = base + content

    def format_docs(self, docs):
    # 검색한 문서 결과를 하나의 문단으로 합쳐줍니다.
        return "\n\n".join(doc.page_content + '\nmetadata=' + str(doc.metadata) for doc in docs)
    
    def query(self, question, result_lang, session_id='unused'):
        self.question = question
        self.ko_query = self.deepl.translate_text(self.question, target_lang='ko').text
        self.session_id = session_id
        self.result_lang = result_lang
        self.qna_route_chain.invoke(question)
        self.store[self.session_id].add_ai_message(self.result)
        return self.result

    def get_session_history(self, session_id: str) -> BaseChatMessageHistory:
        if session_id not in self.store:
            self.store[session_id] = ChatMessageHistory()
        return self.store[session_id]
