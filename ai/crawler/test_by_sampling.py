import pickle
import os

# 현재 스크립트가 위치한 디렉토리 경로를 가져옵니다.
current_directory = os.path.dirname(os.path.realpath(__file__))
os.chdir(current_directory)

# 파일에서 객체를 불러옵니다.
with open('./data/Notice/notice_1.pkl', 'rb') as f:
    loaded_data = pickle.load(f, encoding='utf-8')

# 불러온 객체를 출력합니다.
doc = loaded_data[-6]

print(doc.page_content + '\nmetadata=' + doc.metadata['source'])