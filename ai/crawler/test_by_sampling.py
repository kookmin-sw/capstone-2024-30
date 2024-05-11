import pickle
import os
from langchain.text_splitter import RecursiveCharacterTextSplitter

# 현재 스크립트의 디렉터리 경로를 가져옴
current_dir = os.path.dirname(__file__)

# 상위 디렉터리의 경로를 얻기 위해 다시 한 번 os.path.dirname()을 호출
parent_dir = os.path.dirname(current_dir)
os.chdir(parent_dir)

# 파일에서 객체를 불러옵니다.
with open('./data/NAVER/kookhee_kmu_0_3.pkl', 'rb') as f:
    loaded_data1 = pickle.load(f, encoding='utf-8')

# 불러온 객체를 출력합니다.
# print(type([loaded_data1][0]))
# print(type(loaded_data2[0]))
#print(loaded_data1)

text_splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=50)

splits1 = text_splitter.split_documents(loaded_data1)
print(splits1)
print('++++++++++++++++++++++++++++')
#print(splits2)
