from langchain import hub
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnablePassthrough
from langchain_openai import ChatOpenAI
from llm.prompt import source_prompt, final_prompt
import os

class LLM_RAG:
    def __init__(self, api_key = None):
        if api_key:
            os.environ['OPENAI_API_KEY'] = api_key

        self.llm = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0)
        self.rag_prompt = hub.pull("rlm/rag-prompt")
        self.sorce_prompt = source_prompt()
        self.final_prompt = final_prompt()
        self.rag_chain = None
        self.source_chain = None
        self.chain = None

    def set_ragchain(self, retriever):
        self.rag_chain = (
            {"context": retriever | self.format_docs, "question": RunnablePassthrough()}
            | self.rag_prompt
            | self.llm
            | StrOutputParser()
        )

        self.source_chain = (
            {"context": retriever | self.format_docs, "question": RunnablePassthrough()}
            | self.sorce_prompt
            | self.llm
            | StrOutputParser()
        )
        self.chain = (
            {"content": self.rag_chain, "metadata": self.source_chain, "question": RunnablePassthrough()}
            | self.final_prompt
            | self.llm
            | StrOutputParser()
        )

    def format_docs(self, docs):
    # 검색한 문서 결과를 하나의 문단으로 합쳐줍니다.
        return "\n\n".join(doc.page_content + '\nmetadata=' + str(doc.metadata) for doc in docs)
    
    def query(self, question):
        return self.chain.invoke(question)