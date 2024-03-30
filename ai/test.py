import os

# 현재 스크립트가 위치한 디렉토리 경로를 가져옵니다.
current_directory = os.path.dirname(os.path.realpath(__file__))
os.chdir(current_directory)

# 시작 경로
start_path = './crawler/data/'

# os.walk()를 사용하여 모든 폴더와 파일에 접근
for root, dirs, files in os.walk(start_path):
    print(f"현재 폴더: {root}")

    # 폴더 내의 모든 파일에 접근
    for file in files:
        file_path = file
        print(f"파일: {file_path}")