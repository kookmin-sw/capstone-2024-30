import subprocess
import time

def run_infinite(file_path):
    while True:
        print(f"Executing {file_path}...")
        try:
            subprocess.run(["python", file_path])
            print(f"{file_path} execution completed. Restarting...")
            time.sleep(1)  # 실행 후 1초 대기
        except:
            print('error')
            
        with open('./crawler/data/Notice/notice_count.txt') as r:
            data = int(r.readline())
            if data == 195:
                break
        

if __name__ == "__main__":
    python_file_path = "run_crawler.py"  # 실행할 파이썬 파일 경로
    run_infinite(python_file_path)
