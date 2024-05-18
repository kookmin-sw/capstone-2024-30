from sqlalchemy import *
from sqlalchemy.orm import sessionmaker
import os
from dotenv import load_dotenv

load_dotenv()

DB_URL = f'mysql+pymysql://{os.getenv("MYSQL_USERNAME")}:{os.getenv("MYSQL_PASSWORD")}@{os.getenv("DB_ENDPOINT")}:{os.getenv("DB_PORT")}/{os.getenv("DB_NAME")}'

class Engineconn:

    def __init__(self):
        self.engine = create_engine(DB_URL, pool_recycle = 500)

    def sessionmaker(self):
        Session = sessionmaker(bind=self.engine)
        session = Session()
        return session

    def connection(self):
        conn = self.engine.connect()
        return conn
        
