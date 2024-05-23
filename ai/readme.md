# WorkFlow Overview

**외국민 KUKU (OURS)**  

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/1be0e51b-73cf-4964-8221-11d678a47d88)


**Simple RAG**

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/02bc878b-a121-4ffc-9f09-6be149cf004d)

# Metrics
![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/2d4ed4fc-1f19-44a4-aa30-915b39c84a1c)
[RAGAS](https://docs.ragas.io/en/stable/concepts/metrics/index.html)

Ragas is a framework that helps you evaluate your Retrieval Augmented Generation (RAG) pipelines. RAG denotes a class of LLM applications that use external data to augment the LLM’s context. There are existing tools and frameworks that help you build these pipelines but evaluating it and quantifying your pipeline performance can be hard. This is where Ragas (RAG Assessment) comes in.


 > __비교 모델__ (Comparison model)
- 외국민 KUKU (OURS)
- SimpleRAG
- ChatGPT(gpt-3.5-turbo)
- ON국민 쿠민이


## Faithfulness

This measures the factual consistency of the generated answer against the given context. It is calculated from answer and retrieved context. The answer is scaled to (0,1) range. Higher the better.
The generated answer is regarded as faithful if all the claims that are made in the answer can be inferred from the given context. To calculate this a set of claims from the generated answer is first identified. Then each one of these claims are cross checked with given context to determine if it can be inferred from given context or not. The faithfulness score is given by divided by

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/612cce91-8e97-4613-8463-926a731d1d15)
- Faithfulness는 챗봇의 답변 비율이 얼마나 사실에 기반했는지 평가하는 지표이다.
- 0~1 범위의 값을 가지며 높을 수록 좋다

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/61d253af-08b1-4fc6-b9d0-85b3f924df16)
![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/3e444258-7d20-4fa5-b041-a69ff6764969)

-  디스코드 봇을 통해 국민대 19학번으로 구성된 ‘외국민’ 팀원이 직접 사실관계를 평가하여 측정


## Answer Relevancy

The evaluation metric, Answer Relevancy, focuses on assessing how pertinent the generated answer is to the given prompt. A lower score is assigned to answers that are incomplete or contain redundant information and higher scores indicate better relevancy. This metric is computed using the question, the context and the answer.

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/acd26582-174f-4b4a-9c09-6f355db0190a)
![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/941267d5-135c-4872-a0ed-97e64253ddb5)

The Answer Relevancy is defined as the mean cosine similartiy of the original question to a number of artifical questions, which where generated (reverse engineered) based on the answer

- Answer Relevance은 생성된 답변이 주어진 프롬프트와 얼마나 적절한지를 평가하는 데 초점을 맞춘다. 
- 불완전하거나 중복 정보가 포함된 답변에는 낮은 점수가 할당되고, 더 높은 점수는 더 좋은 적합성을 나타낸다.
- 0~1 범위의 값을 가지며 높을 수록 좋다


![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/b1b1e217-5ad8-4238-8092-605e9ce764da)

Answer Relevance는 Reverse Engineering을 통해 계산된다. 순서는 다음과 같다.
1. 챗봇에게 질문 후 답변을 받는다.
2. 답변을 llm의 입력으로 넣어 질문을 예측하게 한다.
3. 예측된 질문과 원래의 질문의 유사도(코사인 유사도)를 비교한다.

# Latency
- 챗봇에게 쿼리를 보낸 후 답변 응답까지 걸린 평균 소요 시간(sec)
- 낮을 수록 좋다.


![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/30caad13-3e69-4345-b1aa-727aaf97e93c)


# Test Sample

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/5a5bc026-8884-4e44-8b1a-cec26b3216f3)
![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/80c9b745-4c78-430e-9f39-bb0945a27000)

# Test Log 일부

`chatbot_result.xlsx`

![image](https://github.com/kookmin-sw/capstone-2024-30/assets/54922676/63d47585-ad8f-405f-be70-a29cf97db895)

