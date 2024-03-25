# main_crawler
from notice_clawler import NoticeCrawler
import pickle
import tqdm
from langchain.text_splitter import RecursiveCharacterTextSplitter
import os

text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=50)

SERVICE_KEY = os.getenv('CLOVA_API_KEY')
CLOVA_API_URL = os.getenv('CLOVA_API_URL')
crawler = NoticeCrawler(SERVICE_KEY, CLOVA_API_URL)

def Clawling_notice_page_to_page(start=1, end=194, path = './'):
  for page_no in range(start, end+1):
    docs = crawler.crawling_notices_by_page(page_no)
    with open(path+'notice_'+str(page_no)+'.pkl', 'wb') as f:
      pickle.dump(docs, f)