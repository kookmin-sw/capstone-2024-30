from llm.llm_rag import LLM_RAG
from vectordb.vector_db import VectorDB
from dotenv import load_dotenv
import os

load_dotenv()

api_key = os.getenv('OPENAI_API_KEY')
os.environ['OPENAI_API_KEY'] = api_key

vector_db_path = './FAISS'

print('=== Initialize ...... ===')
vdb = VectorDB()
vdb.load_local(vector_db_path)

llm = LLM_RAG()
llm.set_ragchain(vdb.get_retriever())

print("AI: hello! if you want to stop, please enter '0'")
print()

while True:
    q = input("HUMAN : ")
    print()
    if q == str(0):
        break
    print('AI : ', end='')
    print(llm.query(q))
    print()