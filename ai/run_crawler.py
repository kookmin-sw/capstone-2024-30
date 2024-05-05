from crawler.notice_crawler import NoticeCrawler
from crawler.ciss_crawler import CissClawer
from crawler.pdf_reader import PdfReader
from crawler.sw_crawler import SoftwareCrawler

from dotenv import load_dotenv
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
import os
import sys

# 현재 스크립트가 위치한 디렉토리 경로를 가져옵니다.
current_directory = os.path.dirname(os.path.realpath(__file__))
os.chdir(current_directory)

if len(sys.argv) == 1:
    print('Error! Choose your crawling type!!')
    print('ex) python run_crawler.py notice')
    sys.exit(0)
    
crawler_type = sys.argv[1]
print(crawler_type)

if crawler_type == 'notice':
    load_dotenv()

    CLOVA_API_KEY = os.getenv('CLOVA_KEY')
    CLOVA_API_URL = os.getenv('CLOVA_URL')

    nc = NoticeCrawler(CLOVA_API_KEY, CLOVA_API_URL)
    path = './data/Notice/'
    start_point = 1
    with open(path+'notice_count.txt') as r:
        start_point = int(r.readline())
    nc.Crawling_notice_page_to_page(start=start_point, end=195, path = path)

elif crawler_type == 'ciss':
    path = './data/CISS/'
    cc = CissClawer()
    cc.crawling(path)

elif crawler_type == 'pdf':
    path = './data/PDF/'
    pc = PdfReader()
    if not sys.argv[2]:
        print(' Error! please add your pdf file path!')
        print('ex) python run_crawler.py "YOUR PDF PATH"')
        sys.exit(0)

    pdf_path = sys.argv[2]
    pc.read_pdf(pdf_path, path)

elif crawler_type == 'sw':
    path = './data/SW/'
    sc = SoftwareCrawler()
    sc.crawling(path)

else:
    print('Error! Choose valid crawling type!!')
    print('ex) python run_crawler.py notice')