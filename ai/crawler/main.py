import clawler_utils
from dotenv import load_dotenv
import os

load_dotenv()

# 현재 스크립트가 위치한 디렉토리 경로를 가져옵니다.
current_directory = os.path.dirname(os.path.realpath(__file__))
# 작업 디렉토리를 현재 스크립트가 위치한 디렉토리로 변경합니다.
os.chdir(current_directory)


# 공지사항 크롤링 시작
clawler_utils.Clawling_notice_page_to_page(start=1, end=194, path='./data/Notice/') #1~194

# 16, 7