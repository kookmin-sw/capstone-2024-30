from llm.llm_rag import LLM_RAG
from vectordb.vector_db import VectorDB
from dotenv import load_dotenv
import os


# 현재 스크립트가 위치한 디렉토리 경로를 가져옵니다.
current_directory = os.path.dirname(os.path.realpath(__file__))
os.chdir(current_directory)

load_dotenv()

os.environ['OPENAI_API_KEY'] = os.getenv('OPENAI_API_KEY')

# LangSmith 사용시 아래 주석을 해제
# os.environ['LANGCHAIN_API_KEY'] = os.getenv('LANGCHAIN_API_KEY')
# os.environ['LANGCHAIN_ENDPOINT'] = "https://api.smith.langchain.com"
# os.environ["LANGCHAIN_TRACING_V2"] = "true"
# os.environ["LANGCHAIN_PROJECT"] = "test"

vector_db_path = './FAISS'

print('=== Initialize ...... ===')
notice_vdb = VectorDB()
notice_vdb.load_local(vector_db_path + '/NOTICE')
school_vdb = VectorDB()
school_vdb.load_local(vector_db_path + '/SCHOOL_INFO')
naver_vdb = VectorDB()
naver_vdb.load_local(vector_db_path + '/NAVER')

llm = LLM_RAG(trace=True)
llm.set_retriver(data_type='notice', retriever=notice_vdb.get_retriever(k=2))
llm.set_retriver(data_type='school_info', retriever=school_vdb.get_retriever(k=3))
llm.set_retriver(data_type='naver', retriever= naver_vdb.get_retriever(k=5))
llm.set_chain()

print("AI: hello! if you want to stop, please enter '0'")
print()

while True:
    q = input("HUMAN : ")
    print()
    if q == str(0):
        break
    print('AI : ', end='')
    print(llm.query(q, 'en'))
    print()