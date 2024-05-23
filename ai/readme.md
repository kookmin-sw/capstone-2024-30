# WorkFlow Overview

## **외국민 KUKU (OURS)**  

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/dcec3a29-6d66-45f7-a5af-8f7962fd81e7)


- **시나리오 1 : 유저 쿼리가 일상대화일 때**

유저 쿼리가 질문이 아닌, ‘안녕, ‘배고파’, ‘오늘 기분이 좋아’ 같은 casual 대화일 때 파인튜닝된 LLM으로 만들어진  라우터를 통해 쿼리가 ‘질문인지 아닌지’로 분류된다. causal 대화일 때는 ‘국민대학교 학생들과 대화를 하는 친절한 어시스턴트’ 라는 시스템 메시지를 가지고 있는 LLM 모델로 전달되어 일상적인 답변을 생성하고, 유저한테 전달한다.

- **시나리오 2 : 유저 쿼리가 질문일 때**

질문 쿼리는 우선 언어와 상관 없이 한국어로 번역된다. 그 이유는 수집한 거의 모든 데이터가 한국어로 되어 있기 때문에, 쿼리와 문서의 유사도 비교를 용이하게 하기 위함이다. 수집한 데이터는 모두 벡터화 되어 있고 '공지사항 관련', '학교 생활 관련', '그 외 수집한 데이터' 세 가지 분류로 나눠져 있다. 각 데이터 저장소에 우리가 설정한 가중치에 따라 langchain의 앙상블 검색기를 수행된다. 상위 K개(k=10)개의 문서를 참조하여 LLM은 질문에 대한 답변을 생성한다.
이후, 이 답변은 ‘답변이 적절한지 아닌지’ 분류를 위해 Fine tuning된 LLM에 전달된다.

   - **시나리오 2-1 : 질문에 대한 답변이 적절할 때**

질문에 대한 답변이 적절할 때, 한국어로 생성된 답변을 사용자가 기대하는 언어로 번역 되어 사용자에게 전달 된다.

   - **시나리오 2-2 : 질문에 대한 답변이 적절하지 않을 때**

이전에 생성된 답변을 버리고 구글 검색 기반 RAG 시스템 ‘Tavily Search API’를 통해 새롭게 답변을 구성한다. 이후 생성된 답변을 사용자가 기대하는 언어로 번역 하여 사용자에게 전달한다.

## **Simple RAG**

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/02bc878b-a121-4ffc-9f09-6be149cf004d)

# Usage
다음 세 가지 방법 중 선택

### 1. 외국민 App
플레이스토어의 외국민 어플리케이션을 다운받아 챗봇을 사용

### 2. Python
1. `git clone https://github.com/kookmin-sw/capstone-2024-30.git`
2. `cd YOUR PATH/ai/`
3. `pip install -r requirements.txt`
4. 벡터 저장소 FAISS 폴더를 `/ai` 에 위치  [다운로드 링크](https://drive.google.com/file/d/1-U5X_xRg0PLITrDWDNMeZK_NAP5IIwsL/view?usp=sharing)
5. `python run_chatbot.py`

### 3. DiscordBot

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/ea2fd088-3bfa-4fb1-940f-ab34dc6b74d0)

- 디스코드 채널의 KUKU 봇 초대 후 명령어를 통해 채팅
- 봇 초대 권한 필요 (서버 관리자) 
- 봇 초대 링크 : https://discord.com/oauth2/authorize?client_id=1229021729192677488
- `!p 질문 내용` 명령어로 채팅 가능

# Metrics
![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/2d4ed4fc-1f19-44a4-aa30-915b39c84a1c)
[RAGAS](https://docs.ragas.io/en/stable/concepts/metrics/index.html)

```
Ragas is a framework that helps you evaluate your Retrieval Augmented Generation (RAG) pipelines. RAG denotes a class of LLM applications that use external data to augment the LLM’s context. There are existing tools and frameworks that help you build these pipelines but evaluating it and quantifying your pipeline performance can be hard. This is where Ragas (RAG Assessment) comes in.
```


 > __비교 모델__ (Comparison model)
- 외국민 KUKU (OURS)
- SimpleRAG
- ChatGPT(gpt-3.5-turbo)
- ON국민 쿠민이

테스트에 사용된 약 200개의 질문은 [question_list.md](./question_list.md) 에서 확인 가능

## Faithfulness

```
This measures the factual consistency of the generated answer against the given context. It is calculated from answer and retrieved context. The answer is scaled to (0,1) range. Higher the better.
The generated answer is regarded as faithful if all the claims that are made in the answer can be inferred from the given context. To calculate this a set of claims from the generated answer is first identified. Then each one of these claims are cross checked with given context to determine if it can be inferred from given context or not. The faithfulness score is given by divided by
```

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/612cce91-8e97-4613-8463-926a731d1d15)
- Faithfulness는 챗봇의 답변 비율이 얼마나 사실에 기반했는지 평가하는 지표이다.
- 0~1 범위의 값을 가지며 높을 수록 좋다

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/61d253af-08b1-4fc6-b9d0-85b3f924df16)
![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/3e444258-7d20-4fa5-b041-a69ff6764969)

-  디스코드 봇을 통해 국민대 19학번으로 구성된 ‘외국민’ 팀원이 직접 사실관계를 평가하여 측정
![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/c49c1e68-b4d9-4bbf-8d32-7cb2036f15cd)


## Answer Relevancy

```
The evaluation metric, Answer Relevancy, focuses on assessing how pertinent the generated answer is to the given prompt. A lower score is assigned to answers that are incomplete or contain redundant information and higher scores indicate better relevancy. This metric is computed using the question, the context and the answer.
```

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/acd26582-174f-4b4a-9c09-6f355db0190a)
![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/941267d5-135c-4872-a0ed-97e64253ddb5)

```
The Answer Relevancy is defined as the mean cosine similartiy of the original question to a number of artifical questions, which where generated (reverse engineered) based on the answer
```

- Answer Relevance은 생성된 답변이 주어진 프롬프트와 얼마나 적절한지를 평가하는 데 초점을 맞춘다. 
- 불완전하거나 중복 정보가 포함된 답변에는 낮은 점수가 할당되고, 더 높은 점수는 더 좋은 적합성을 나타낸다.
- 0~1 범위의 값을 가지며 높을 수록 좋다


![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/b1b1e217-5ad8-4238-8092-605e9ce764da)

Answer Relevance는 Reverse Engineering을 통해 계산된다. 순서는 다음과 같다.
1. 챗봇에게 질문 후 답변을 받는다.
2. 답변을 llm의 입력으로 넣어 질문을 예측하게 한다.
3. 예측된 질문과 원래의 질문의 유사도(코사인 유사도)를 비교한다.

## Latency
- 챗봇에게 쿼리를 보낸 후 답변 응답까지 걸린 평균 소요 시간(sec)
- 낮을 수록 좋다.


![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/30caad13-3e69-4345-b1aa-727aaf97e93c)


# Test Sample

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/5a5bc026-8884-4e44-8b1a-cec26b3216f3)
![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/80c9b745-4c78-430e-9f39-bb0945a27000)

# Test Log

`chatbot_result.xlsx`

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/d6442b14-606f-4182-976c-a1dfa241b5ee)

