from llm_rag import LLM_RAG
from vectordb.vector_db import VectorDB
from dotenv import load_dotenv
import os

# 현재 스크립트가 위치한 디렉토리 경로를 가져옵니다.
current_directory = os.path.dirname(os.path.realpath(__file__))
os.chdir(current_directory)

load_dotenv()

api_key = os.getenv('OPENAI_API_KEY')
os.environ['OPENAI_API_KEY'] = api_key

vector_db_path = 'C:/Users/khs03/Desktop/capstone/vectordb/FAISS'

vdb = VectorDB()
vdb.load_local(vector_db_path)

llm = LLM_RAG()
llm.set_ragchain(vdb.get_retriever())

import sys

while True:
    q = sys.stdin.readline().rstrip()
    if q == str(0):
        break
    print('generating ....')
    print(llm.query(q))