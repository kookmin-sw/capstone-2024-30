import pickle
import os

# 현재 스크립트가 위치한 디렉토리 경로를 가져옵니다.
current_directory = os.path.dirname(os.path.realpath(__file__))
# 작업 디렉토리를 현재 스크립트가 위치한 디렉토리로 변경합니다.
os.chdir(current_directory)

# 파일에서 객체를 불러옵니다.
with open('./data/Notice/notice_4.pkl', 'rb') as f:
    loaded_data = pickle.load(f, encoding='utf-8')

# 불러온 객체를 출력합니다.
sample = loaded_data[-3]
print(sample)