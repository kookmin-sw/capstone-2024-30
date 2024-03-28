from langchain import hub
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnablePassthrough
from langchain_openai import ChatOpenAI
import os

class LLM_RAG:
    def __init__(self, api_key = None):

        super().__init__()

        if api_key:
            os.environ['OPENAI_API_KEY'] = api_key

        self.llm = ChatOpenAI(model_name="gpt-4", temperature=0)
        self.prompt = hub.pull("rlm/rag-prompt")

    def set_ragchain(self, retriever):
        self.rag_chain = (
            {"context": retriever | self.format_docs, "question": RunnablePassthrough()}
            | self.prompt
            | self.llm
            | StrOutputParser()
        )

    def format_docs(self, docs):
        # 검색한 문서 결과를 하나의 문단으로 합쳐줍니다.
        return "\n\n".join(doc.page_content + '\nmetadata=' + doc.metadata['source'] for doc in docs)
    
    def query(self, question):
        return self.rag_chain.invoke(question)