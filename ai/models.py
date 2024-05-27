from sqlalchemy import Column, Integer, String, ForeignKey, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
import pytz
from datetime import datetime
from database import Engineconn

Base = declarative_base()
engine = Engineconn()

class Announcement(Base):
    __tablename__ = 'announcements'

    id = Column(Integer, name="announcement_id", primary_key=True)
    type = Column(String, nullable=False)
    title = Column(String, nullable=False)
    writtenDate = Column(DateTime, name="written_date", default=datetime.now(pytz.timezone('Asia/Seoul')))  # 서울 시간대로 기본값 설정
    department = Column(String)
    author = Column(String)
    authorPhone = Column(String, name="author_phone")
    document = Column(String)
    language = Column(String)
    url = Column(String)
    files = relationship('AnnouncementFile', back_populates='announcement')

class AnnouncementFile(Base):
    __tablename__ = 'announcement_files'

    id = Column(Integer, primary_key=True)
    link = Column(String)
    title = Column(String)
    announcement_id = Column(Integer, ForeignKey('announcements.announcement_id'))
    announcement = relationship('Announcement', back_populates='files')