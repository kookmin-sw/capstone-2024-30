# Chat bot `KUKU` 소개

국민대에 관한 모든 것을 물어보세요 !  
국민대 관련 데이터를 기반으로 답변을 생성하는 챗봇 <쿠쿠>입니다.  

# 학습한 데이터

- [국민대 2023 요람 PDF](https://www.kookmin.ac.kr/comm/cmfile/thumbnail2.do?encSvrFileNm=223d2bdfdbb4df30ad85271267bd6e6a0a913159736ab9843bb76fc00eeeb5ddb1e88f35002b9cf1b749bfe96b751f16b8be21ad5273d348a74b10a57513dd4540bbcb178d3151db4d507c693a1f7ef9&encFileGrpSeq=8e8e9041def64eb5f7f8c21154bcff06&encFileSeq=cf9f1626435aafc6e0e182b36c8e23d9)
- [2023~2024.03.28 국민대 전체 공지사항](https://www.kookmin.ac.kr/user/kmuNews/notice/index.do)

# 실행 방법


2024_03_30 아나콘다 환경 python 3.8 에서 실행 확인

1. /ai 경로로 작업 디렉토리 이동
2. 패키지 설치  `pip install -r requirements.txt` 
3. /ai 경로에 .env 파일 생성 (OPENAI_API_KEY = 'your_api')
4. `python run_chatbot.py` 

# TEST

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/6b7c8514-35dd-41bb-9815-56a182a7ccfb)

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/e37af8f8-a35b-4808-a357-aff5aebb8d88)

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/d7b5cd40-43b7-4cca-8be8-6fff257ed303)
