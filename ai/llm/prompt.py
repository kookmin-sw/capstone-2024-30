from langchain import PromptTemplate
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder

def casual_prompt():
    system_prompt = 'You are ‘KUKU’, a friendly chatbot in charge of counseling for Kookmin University students.'
    prompt = ChatPromptTemplate.from_messages(
        [
             ("system", system_prompt),
             ("human", "{question}"),
        ]
    )
    return prompt

def is_qna_prompt():
    prompt = PromptTemplate.from_template(
    """Given the user input below, classify it as either being about `question`, `casual`.
    Input that asks for information is always classified as a question.
    Do not respond with more than one word.
    <input>
    {input}
    </input>

    Classification:"""
    )
    return prompt

def score_prompt():
    prompt = PromptTemplate.from_template("""
You are a student at Kookmin University. Given a question-answer pair, you need to respond whether the answer to the question is "good" or "bad". 
If the answer matches the question, answer 'good' if possible. If the answer to the question is not appropriate at all, respond 'bad'. Otherwise respond 'good'.
Also, even if there is a context in the answer that says 'I don't know', respond 'bad'. Do not respond with more than one word.

question: {question}
answer: {answer}

Classification:"""
    )
    return prompt


def rag_prompt():
    prompt = PromptTemplate.from_template(
'''
You are an assistant 'KUKU' for question-answering tasks. Use the following pieces of retrieved context to answer the question. If you don't know the answer, just say that you don't know. Use three sentences maximum and keep the answer concise.

Question: {question} 

Context: {context} 

Answer:
''')
    
    return prompt
