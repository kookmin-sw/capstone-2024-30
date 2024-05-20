from typing import Union, Optional
from fastapi import FastAPI, UploadFile, BackgroundTasks, Request
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
from pydantic import BaseModel
from llm.llm_rag import LLM_RAG
from vectordb.vector_db import VectorDB
from dotenv import load_dotenv
import os
import uvicorn
import datetime
from database import Engineconn
from models import Announcement
import sched
from apscheduler.schedulers.background import BackgroundScheduler
import logging
from langchain_core.documents.base import Document
import pickle
 
sched = BackgroundScheduler(timezone='Asia/Seoul')

class Query(BaseModel):
    query: str

class CustomException(Exception):
    def __init__(self, name: str):
        self.name = name

@asynccontextmanager
async def lifespan(app:FastAPI):
    global llm
    global vdb

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
    naver_vdb = VectorDB()
    naver_vdb.load_local(vector_db_path + '/NAVER')

    llm = LLM_RAG(trace=True)
    llm.set_retriver(data_type='notice', retriever=notice_vdb.get_retriever(k=2))
    llm.set_retriver(data_type='school_info', retriever=school_vdb.get_retriever(k=3))
    llm.set_retriver(data_type='naver', retriever= naver_vdb.get_retriever(k=5))
    llm.set_chain()
    yield

app = FastAPI(lifespan=lifespan)

engineconn = Engineconn()
engine = engineconn.engine
session = engineconn.sessionmaker()

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

@sched.scheduled_job('cron', hour='1', minute='30', id='load announcement')
def log_new_announcements():
    # 하루 전의 시간 계산
    one_day_ago = datetime.datetime.now(datetime.UTC) - datetime.timedelta(days=1)
    # 하루 동안 추가된 announcement 조회
    new_announcements = session.query(Announcement).filter(Announcement.writtenDate >= one_day_ago).all()
    # 조회된 announcement 로그에 기록
    docs = []
    for announcement in new_announcements:
        doc = Document()
        doc.page_content = announcement.document
        doc.metadata['title'] = announcement.title
        doc.metadata['datetime'] = announcement.writtenDate
        docs.append(doc)
    with open(f'{datetime.datetime.now(datetime.UTC)}.pkl', 'wb') as f:
            pickle.dump(docs, f)

@app.get("/")
async def initiate():
    sched.start()
    return "안녕하세요! 국민대학교 전용 챗봇 KUKU입니다. 국민대학교에 대한 건 모든 질문해주세요!"

@app.post("/query")
async def query(query: Query):
    try:
        ans = llm.query(query.query, query.target_lang)
    except:
        raise CustomException(name="chatbot error")
    return JSONResponse(status_code=200, content={'success': True,
                                                  'message': 'success',
                                                  'response': {
                                                    'answer': ans
                                                    }})

@app.post("/input")
async def input(data: UploadFile):
    vdb.add_content(data.file)
    return 

@app.exception_handler(CustomException)
async def MyCustomExceptionHandler(request: Request, exception: CustomException):
  return JSONResponse(status_code = 400,
                      content = {'success': False,
                                 'message': 'failed'})


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)