# 👋 외국인 유학생들을 위한 앱, 외국민

![최종 발표자료](https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/20fc41c1-8a22-4c90-a1f1-8539dea92ed1)

<div style="text-align: center; display: flex; flex-direction: column;">
    <a href="https://drive.google.com/drive/folders/1qLw6-LrNG9_9Of6zh4YmYm2VoOt31NlA?usp=drive_link">
        [중간발표 자료 및 보고서]
    </a>
    <br>
    <a href="https://drive.google.com/drive/folders/1gVtsjX9nk8KhyeNu-hTzpeZjZnjj-pR8?usp=sharing">
        [최종발표 자료&포스터 및 보고서]
    </a>
    <br>
    `파트별 자세한 내용은 각 프로젝트 디렉토리의 readme에 있습니다.`
    <table>
        <tr align="center">
            <td>
                프론트
            </td>
            <td>
                백
            </td>
            <td>
                AI
            </td>
        </tr>
        <tr align="center">
            <td>
                <a href="https://kookmin-sw.github.io/capstone-2024-30/front/">README.md</a>
            </td>
            <td>
                <a href="https://kookmin-sw.github.io/capstone-2024-30/back/">README.md</a>
            </td>
            <td>
                <a href="https://kookmin-sw.github.io/capstone-2024-30/ai/">README.md</a>
            </td>
        </tr>
    </table>
</div>

<br>

<div style="text-align: center; display: flex; flex-direction: column;">
    <p align="center">
        <img src="https://github.com/kookmin-sw/capstone-2024-30/assets/53148103/6ecaf324-4b45-4c73-a30f-503215347794" width="300" height="300"/>
    </p>
    <br>
    <a href="https://play.google.com/store/apps/details?id=com.foreign.kookmin&pli=1">Play 스토어 다운로드</a>
</div>

## 1. 프로젝트 소개

이 프로젝트는 국민대학교 유학생들이 겪는 언어적, 문화적 불편함을 해결하기 위한 프로젝트입니다. 이 프로젝트에서 제공하는 앱에서 유학생들이 캠퍼스 생활에 빠르게 적응할 수 있도록 다양한 정보와 서비스를 제공합니다.

<br>

## 2. Abstract

This project aims to develop a comprehensive app service for international students studying at Kookmin University. The app provides a variety of information and services to help students quickly adapt to campus life.

<br>

## 3. 프로젝트 기능

#### 1️⃣ 번역된 공지사항 / 학식 / 학교정보 제공

국민대학교에서는 공지사항, 학식, 학교정보의 번역을 잘 지원하지 않습니다. 이에따라 외국인 유학생들은 매번 번역기를 사용하여 학교에 대한 정보를 얻기 때문에 정보의 접근성이 낮습니다.

따라서, 외국민 서비스는 설정한 언어에 맞춰서 공지사항/학식/학교정보 번역본을 제공합니다.

|번역된 공지사항|공지사항 디테일|번역된 학식정보|
|------|---|---|
|<img width="388" src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/8f30d871-0e41-4009-8832-4f7cefd1867b">|<img width="388" src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/62146792-21cc-4eb4-bbfd-98daa4ae159e">|<img width="388" src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/34695d44-0efb-4cb7-9efa-a1547ab8ee82">|

<br>

#### 2️⃣ 챗봇 기능

국민대학교에서는 ON국민 챗봇 "쿠민이"를 서비스하고있으나, 성능이 매우 형편없습니다. 간단한 질문에도 동문서답을 하거나, 영어로 질문했는데 한글로 답변하는 등 전혀 챗봇으로서의 기능을 수행하지 못하고 있습니다.

따라서, 외국민은 RAG와 LLM을 사용하여 국민대학교에 특화된 답변을 제공하고 다국어를 지원하는 "KuKu" 챗봇을 제공합니다.

|국민대 관련 질문|다국어 지원|일상 대화|
|------|---|---|
|<img width="388" src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/4ebbe481-d563-45c7-b8dc-65c87877d6c6">|<img width="388" src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/7b9c7a7f-339d-4a53-ad1d-a90a3988a75e">|<img width="388" src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/b10efb4b-110c-4ca8-aff7-c38445256123">|

<br>

#### 3️⃣ 발음 교정 기능

많은 외국인들은 한국에 와서 언어 문제로 힘들어합니다. 특히 학교 생활을 하다보면 발표를 하거나 일상생활에서 의사소통을 해야할 때, 본인의 발음이 정확한지 확인할 방법이 없어서 힘들어합니다.

따라서, 외국민은 자신의 발표 스크립트를 입력으로 넣어서 발음 평가를 받을 수 있을 뿐만 아니라, 한국의 일상생활에서 많이 쓰이는 여러 표현들을 연습할 수 있도록하여 한국 유학생활을 돕고자 합니다.

|일상생활에 자주쓰는 예문 지원|문장 커스텀 지원|발음 평가 제공|
|------|---|---|
|<img width="388" src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/d31a5971-f01b-469f-8345-db9ea5c152cb">|<img width="388" src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/d0cb0cb5-7043-4737-8994-119dc5139220">|<img width="388" src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/dee0fc3a-481e-4612-bb2a-760321efdfbe">|

<br>

#### 4️⃣ 헬퍼 매칭 기능

많은 외국인들이 낯선 땅에 왔을 때 도움을 받을 사람이 없어서 매우 힘들어합니다.

따라서, 외국민은 외국인들을 도울 수 있도록 헬퍼 매칭 기능을 제공합니다. 한국인 or 오랜 유학생활을 하여 한국 생활에 익숙해진 외국인 헬퍼를 구할 수 있도록 커뮤니티를 제공합니다.

|헬퍼 및 헬피 게시판|디테일|채팅|
|------|---|---|
|<img width="388" src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/60f40d3b-4930-4c4a-bcb3-1e97a75119c0">|<img width="388" src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/141b4d12-070e-4e59-abe2-22bd5f96547e">|<img width="388" src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/00644b04-3e5e-416f-ba57-b45662e45869">|

<br>

#### 5️⃣ Q&A와 FAQ 기능

유학생들이 한국생활에서 궁금한 것을 물어볼만한 곳이 마땅치 않고, ON국민에 있는 FAQ의 존재를 알기 쉽지 않습니다. 하지만, 이 FAQ 또한 번역을 제공하지 않고 있습니다.

따라서, 외국민은 Q&A 게시판과 다국어로 번역된 FAQ를 제공합니다.

|Q&A 게시판|디테일|FAQ 조회|
|------|---|---|
|<img width="388" src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/5801b9fa-fb82-48f6-a675-0997c6bfae34">|<img width="388" src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/ae9525c7-c605-4e88-9ea2-49285bbe84bd">|<img width="388" src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/dcaa5cf2-0f9c-457f-a81c-351bd4578ca7">|


<br>

## 4. 소개 영상

[![Video Label](http://img.youtube.com/vi/4em2UsKIx_U/0.jpg)](https://youtu.be/4em2UsKIx_U)

<br>

## 5. 팀원 소개

<table>
    <tr align="center">
        <td><img src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/5a581293-0461-462b-b14d-5c98c079860f" width="250"></td>
        <td><img src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/074c4543-e44a-4bb6-baf8-7c3f0d9f1e3d" width="250"></td>
        <td><img src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/7627b57d-585c-4021-b02a-5ae6daded453" width="250"></td>
    </tr>
    <tr align="center">
        <td>최지훈</td>
        <td>김민제</td>
        <td>조현진</td>
    </tr>
    <tr align="center">
        <td>****1683</td>
        <td>****1557</td>
        <td>****1675</td>
    </tr>
    <tr align="center">
        <td>👑 Frontend</td>
        <td>Frontend</td>
        <td>Backend</td>
    </tr>
</table>

<table>
    <tr align="center">
        <td><img src="https://github.com/kookmin-sw/capstone-2024-30/assets/53148103/9c6d6e4b-0f85-4489-9f93-f1cf6774fd50" width="250"></td>
        <td><img src="https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/cad2c04e-8c71-44c0-9be1-9f29c0244243" width="250"></td>
        <td><img src="https://github.com/kookmin-sw/capstone-2024-30/assets/52407470/1c9ac172-5d97-4002-b254-c003f5d07ac2" width="250"></td>
    </tr>
    <tr align="center">
        <td>채원찬</td>
        <td>김혜성</td>
        <td>최영락</td>
    </tr>
    <tr align="center">
        <td>****1676</td>
        <td>****1582</td>
        <td>****1678</td>
    </tr>
    <tr align="center">
        <td>Backend</td>
        <td>AI</td>
        <td>AI</td>
    </tr>
</table>

<br>

## 6. 기술스택

### 🛠 Frontend

| 역할                 | 종류                                                                                                                                                                                                                                                |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Framework            | <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>                                                                                                                                           |
| Database             | <img alt="RED" src ="https://img.shields.io/badge/SQLite-003B57.svg?&style=for-the-badge&logo=SQLite&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/Firebase-FFCA28.svg?&style=for-the-badge&logo=Firebase&logoColor=white"/> |
| Programming Language | <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white"/>                                                                                                                                                 |
| Device               | <img src="https://img.shields.io/badge/Android-4A853?style=for-the-badge&logo=Android&logoColor=white"/> <img src="https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=iOS&logoColor=white"/>                                          |

<br />

### 💾 Backend

| 역할                 | 종류                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Framework            | <img alt="RED" src ="https://img.shields.io/badge/SPRING Boot-6DB33F.svg?&style=for-the-badge&logo=SpringBoot&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/Spring Security-6DB33F.svg?&style=for-the-badge&logo=springsecurity&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/Spring Cloud Gateway-6DB33F.svg?&style=for-the-badge&logo=Spring&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/Ruby On Rails-D30001.svg?&style=for-the-badge&logo=rubyonrails&logoColor=white"/>                                                                                                                                                                                                                                                                                                                                                          |
| Database             | <img alt="RED" src ="https://img.shields.io/badge/MySQL-4479A1.svg?&style=for-the-badge&logo=MySQL&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/Redis-DC382D.svg?&style=for-the-badge&logo=Redis&logoColor=white"/>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| Programming Language | <img alt="RED" src ="https://img.shields.io/badge/JAVA-004027.svg?&style=for-the-badge&logo=Jameson&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/Ruby-CC342D.svg?&style=for-the-badge&logo=Ruby&logoColor=white"/>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| Test                 | <img alt="RED" src ="https://img.shields.io/badge/JUnit5-25A162.svg?&style=for-the-badge&logo=JUnit5&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/Test Conatiner-333333.svg?&style=for-the-badge&logo=linuxcontainers&logoColor=white"/>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| Deploy               | <img alt="RED" src ="https://img.shields.io/badge/Nginx-009639.svg?&style=for-the-badge&logo=nginx&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/Docker-2496ED.svg?&style=for-the-badge&logo=docker&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/Amazon EC2-FF9900.svg?&style=for-the-badge&logo=AmazonEC2&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/Amazon Rds-527FFF.svg?&style=for-the-badge&logo=AmazonRds&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/Amazon S3-569A31.svg?&style=for-the-badge&logo=AmazonS3&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/Amazon Route 53-8C4FFF.svg?&style=for-the-badge&logo=Amazon Route 53&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/Certbot-FF1E0D.svg?&style=for-the-badge&logo=Certbot&logoColor=white"/> |
| CI/CD                | <img alt="RED" src ="https://img.shields.io/badge/Github Actions-2088FF.svg?&style=for-the-badge&logo=githubactions&logoColor=white"/>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| ETC                  | <img alt="RED" src ="https://img.shields.io/badge/Azure Speech SDK-0078D4.svg?&style=for-the-badge&logo=Microsoft Azure&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/Let's Encrypt-003A70.svg?&style=for-the-badge&logo=letsencrypt&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/DeepL-0F2B46.svg?&style=for-the-badge&logo=DeepL&logoColor=white"/>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |

<br />

### 📻 AI

| 역할                 | 종류                                                                                                                                                                                                                                                        |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Programming Language | <img alt="RED" src ="https://img.shields.io/badge/Python-3776AB.svg?&style=for-the-badge&logo=python&logoColor=white"/>                                                                                                                                     |
| Development          | <img alt="RED" src ="https://img.shields.io/badge/OpenAI-412991.svg?&style=for-the-badge&logo=openai&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/Google Colab-F9AB00.svg?&style=for-the-badge&logo=google colab&logoColor=white"/> |
| Technology           | <img alt="RED" src ="https://img.shields.io/badge/FAISS-3B5EE9.svg?&style=for-the-badge&logo=faiss&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/RAG-000000.svg?&style=for-the-badge&logo=rag&logoColor=white"/>                     |
| Test                 | <img src="https://img.shields.io/badge/LangSmith-7EBC6F?style=for-the-badge&logo=langsmith&logoColor=white"/>                                                                                                                                               |
| Server               | <img src="https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white"/>                                                                                                                                                   |

<br />

### 🔨 Tools

| 역할            | 종류                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Version Control | <img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white"> <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white">                                                                                                                                                                                                                                                                                                                                                                                               |
| Cooperation     | <img alt="RED" src ="https://img.shields.io/badge/Notion-000000.svg?&style=for-the-badge&logo=Notion&logoColor=white"/> <img src="https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white"> <img src="https://img.shields.io/badge/Discord-5865F2?style=for-the-badge&logo=discord&logoColor=white"> <img alt="RED" src ="https://img.shields.io/badge/Swagger-85EA2D.svg?&style=for-the-badge&logo=swagger&logoColor=white"/> <img alt="RED" src ="https://img.shields.io/badge/diagrams.net-F08705.svg?&style=for-the-badge&logo=diagramsdotnet&logoColor=white"/> |
| Test            | <img src="https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=Postman&logoColor=white"/> <img src="https://img.shields.io/badge/Apache Jmeter-D22128?style=for-the-badge&logo=apachejmeter&logoColor=white"/>                                                                                                                                                                                                                                                                                                                                                                        |

<br />

<br>

## 7. 시스템 구조

### 💻 서비스 아키택처

<br>
<img src = "https://github.com/kookmin-sw/capstone-2024-30/assets/55117706/bc51c38d-aa69-4b6c-a152-7d5cc7d197a4" width=800>

### 🤖 챗봇 아키텍처

<br>
<img src = "https://github.com/kookmin-sw/capstone-2024-30/assets/55117706/e059e861-d395-4634-bcab-8de9aea6fcaf" width=900>

### 📂 디렉토리 구조

```
├── 📂.github

├── 📂front 🗂 프론트 앱 소스 (Flutter)

├── 📂back-gateway 🗂 백엔드 Api Gateway (Spring Cloud Gateway)

├── 📂back 🗂 백엔드 메인 비즈니스 서버 소스(Spring Boot)

├── 📂back-chat 🗂 백엔드 채팅 서버 소스 (Ruby on Rails)

├── 📂ai 🗂 KuKu 채팅 봇 소스

└── 📕Readme.md
```

## 8. 사용법

### Frontend

#### 1. 플러터 설치

1. Flutter 공식 웹사이트([https://flutter.dev](https://flutter.dev))에 접속
2. `Get Started`를 클릭하여 설치 가이드를 따라 설치
3. 설치가 완료되면, 터미널 또는 커맨드 프롬프트를 열고 `flutter doctor` 명령어를 실행하여 설치가 올바르게 되었는지 확인

#### 2. 프로젝트 디렉토리 이동

```
cd front/capstone_front
```

#### 3. 플러터 패키지 설치

```
flutter pub get
```

#### 4. 프로젝트 실행

```
flutter run
```

<br>

### Backend

`.env.example`을 바탕으로 `.env`를 작성합니다. 그 다음

```
docker-compose up -d
```

를 통해 docker compose를 통하여 실행하시면 됩니다. 이미지는 모두 Dockerhub에 업로드 되어 있습니다.

<br>

### AI

### Chat bot `KUKU` 소개

국민대에 관한 모든 것을 물어보세요 !  
국민대 관련 데이터를 기반으로 답변을 생성하는 챗봇 <쿠쿠>입니다.

### 학습한 데이터

- [국민대 2023 요람 PDF](https://www.kookmin.ac.kr/comm/cmfile/thumbnail2.do?encSvrFileNm=223d2bdfdbb4df30ad85271267bd6e6a0a913159736ab9843bb76fc00eeeb5ddb1e88f35002b9cf1b749bfe96b751f16b8be21ad5273d348a74b10a57513dd4540bbcb178d3151db4d507c693a1f7ef9&encFileGrpSeq=8e8e9041def64eb5f7f8c21154bcff06&encFileSeq=cf9f1626435aafc6e0e182b36c8e23d9)
- [2023~2024.03.28 국민대 전체 공지사항](https://www.kookmin.ac.kr/user/kmuNews/notice/index.do)

### 실행 방법

2024_03_30 아나콘다 환경 python 3.8 에서 실행 확인

1. /ai 경로로 작업 디렉토리 이동
2. 패키지 설치 `pip install -r requirements.txt`
3. /ai 경로에 .env 파일 생성 (OPENAI_API_KEY = 'your_api')
4. `python run_chatbot.py`

### TEST

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/6b7c8514-35dd-41bb-9815-56a182a7ccfb)

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/e37af8f8-a35b-4808-a357-aff5aebb8d88)

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/d7b5cd40-43b7-4cca-8be8-6fff257ed303)

## 9. 기타

<br>
