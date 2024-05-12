from typing import Union, Optional
from fastapi import FastAPI, UploadFile, BackgroundTasks, Header
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
from pydantic import BaseModel
from llm.llm_rag import LLM_RAG
from vectordb.vector_db import VectorDB
from dotenv import load_dotenv
import os
import uvicorn
import datetime
import schedule
import time
from database import Engineconn
from models import Announcement, AnnouncementFile
import sched
from apscheduler.schedulers.background import BackgroundScheduler
import logging
 
sched = BackgroundScheduler(timezone='Asia/Seoul')

class Query(BaseModel):
    query: str
    target_lang: str

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

@sched.scheduled_job('cron', hour='15', minute='51', id='load announcement')
def log_new_announcements():
    # 하루 전의 시간 계산
    one_day_ago = datetime.datetime.now(datetime.UTC) - datetime.timedelta(days=1)
    # 하루 동안 추가된 announcement 조회
    new_announcements = session.query(Announcement).filter(Announcement.writtenDate >= one_day_ago).all()
    # 조회된 announcement 로그에 기록
    for announcement in new_announcements:
        logging.info(f"New announcement: Title - {announcement.title}, Content - {announcement.url}")

@app.get("/")
async def initiate():
    sched.start()
    return "안녕하세요! 국민대학교 전용 챗봇 KUKU입니다. 국민대학교에 대한 건 모든 질문해주세요!"

@app.post("/api/chatbot")
async def query(query: Query, x_user_id: Optional[str] = Header(None)):
    try:
        ans = llm.query(x_user_id, query.query, query.target_lang)
    except:
        return {'success': False,
                'message': 'failed'}
    return {'success': True,
            'message': 'success',
            'response': {
                'answer': ans
            }}

@app.get("/api/cahtbot_close")
async def close(x_user_id: Optional[str] = Header(None)):
    try:
        ans = llm.query(x_user_id, query.query, query.target_lang)
    except:
        return {'success': False,
                'message': 'failed'}
    return {'success': True,
            'message': 'success',
            'response': {
                'answer': ans
            }}



if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)