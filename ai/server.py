from typing import Union
from fastapi import FastAPI, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
from pydantic import BaseModel
from llm.llm_rag import LLM_RAG
from vectordb.vector_db import VectorDB
from dotenv import load_dotenv
import os
import uvicorn

class Query(BaseModel):
    query: str

@asynccontextmanager
async def lifespan(app:FastAPI):
    global llm
    global vdb
    print("a")

    current_directory = os.path.dirname(os.path.realpath(__file__))
    os.chdir(current_directory)
    load_dotenv()
    api_key = os.getenv('OPENAI_API_KEY')
    os.environ['OPENAI_API_KEY'] = api_key
    vector_db_path = './FAISS'
    print('=== Initialize ...... ===')
    notice_vdb = VectorDB()
    notice_vdb.load_local(vector_db_path + '/NOTICE')
    school_vdb = VectorDB()
    school_vdb.load_local(vector_db_path + '/SCHOOL_INFO')

    llm = LLM_RAG(trace=True)
    llm.set_retriver(data_type='notice', retriever=notice_vdb.get_retriever())
    llm.set_retriver(data_type='school_info', retriever=school_vdb.get_retriever())
    llm.set_chain()
    yield

app = FastAPI(lifespan=lifespan)

origins = [
    "http://localhost.tiangolo.com",
    "https://localhost.tiangolo.com",
    "http://localhost",
    "http://0.0.0.0:8000",
    "http://0.0.0.0:8080"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def initiate():
    return "안녕하세요! 국민대학교 전용 챗봇 KUKU입니다. 국민대학교에 대한 건 모든 질문해주세요!"

@app.post("/query")
async def query(query: Query):
    return {'code': '200',
            'message': 'success',
            'response': {
                'answer': llm.query(query.query, 'ko')
            }}

@app.post("/input")
async def input(data: UploadFile):
    vdb.add_content(data.file)
    return 


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)