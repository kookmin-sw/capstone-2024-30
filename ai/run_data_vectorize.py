from vectordb.vector_db import VectorDB
import os
import tqdm
from dotenv import load_dotenv

# 현재 스크립트가 위치한 디렉토리 경로를 가져옵니다.
current_directory = os.path.dirname(os.path.realpath(__file__))
os.chdir(current_directory)

load_dotenv()
api_key = os.getenv('OPENAI_API_KEY')
vdb = VectorDB(api_key)

data_dir_path = './data'
FAISS_path = "./FAISS"

def access_all_folders_and_files(vdb, source_directory_path, dest_directory_path, extension_name):
        # os.walk()를 사용하여 모든 폴더와 파일에 접근
    for root, dirs, files in os.walk(source_directory_path):
        print(f" --- current path --- : {root}")

        # 폴더 내의 모든 파일에 접근
        for file in tqdm.tqdm(files):
            if file.endswith(extension_name):
                vdb.add_content(data_dir_path+'/'+file, dest_directory_path)

access_all_folders_and_files(vdb, data_dir_path, FAISS_path, '.pkl')