from vector_db import VectorDB
import os
import tqdm
from dotenv import load_dotenv

api_key = os.getenv('OPENAI_API_KEY')

vdb = VectorDB(api_key)

notice_path = 'C:/Users/khs03/Desktop/capstone/crawler/data/Notice'
FAISS_path = "C:/Users/khs03/Desktop/capstone/vectordb/FAISS"

def convert_to_vec(vdb, source_directory_path, dest_directory_path, extension_name):
    file_names = os.listdir(source_directory_path)
    target_files = [file for file in file_names if file.endswith(extension_name)]
    for f in tqdm.tqdm(target_files):
        vdb.add_content(source_directory_path+'./'+f, dest_directory_path)

convert_to_vec(vdb, notice_path, FAISS_path, '.pkl')