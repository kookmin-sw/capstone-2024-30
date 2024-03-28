from crawler.notice_crawler import NoticeCrawler
from dotenv import load_dotenv
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
import os

load_dotenv()

CLOVA_API_KEY = os.getenv('CLOVA_KEY')
CLOVA_API_URL = os.getenv('CLOVA_URL')

directory_path = './crawler/data/'

nc = NoticeCrawler(CLOVA_API_KEY, CLOVA_API_URL)
path = './crawler/data/Notice/'
start_point = 1
with open(path+'notice_count.txt') as r:
    start_point = int(r.readline())
nc.Crawling_notice_page_to_page(start=start_point, end=195, path = path)