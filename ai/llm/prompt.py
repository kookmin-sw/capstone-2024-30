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

def combine_result_prompt():
    prompt = PromptTemplate.from_template("""
    You are an assistant for question-answering tasks. Use the following informations of 'notice_info' and 'school_info' to answer the question.  If you can't make the answer, just say that you don't know. Include as much of the provided information as possible.
    Question: {question}
    Notice_info: {notice_info}
    School_info: {school_info}
    Answer:"""
    )
    return prompt

def score_prompt():
    prompt = PromptTemplate.from_template("""
    I am a student at Kookmin University. Given a question-answer pair, you need to respond whether the answer to the question is "good" or "bad". 
    If it answers the question well, respond 'good'. otherwise respond 'bad'.
    Also, even if there is a context in the answer that says 'I don't know', you must respond as 'bad'. Do not respond with more than one word.

    question: {question}
    answer: {answer}

    Classification:"""
    )
    return prompt

def contextualize_prompt():

    contextualize_q_system_prompt = """You're an assistant that transforms follow-up questions into independent query. For instance, if there's a memory like "Tell me about the universe" and the user asks, "Are there any books related to that?" you should respond with "Are there any books related to space?"
    DO NOT answer the question. Given memories and recent user query, you need to generate standalone questions that incorporate the context of the conversation by referring to the chat history. 
    In other words, you should create questions that can be understood independently without referencing the memories. You need to make the question more specific, such as changing the pronoun like 'that' or 'this'. Please DO NOT answer the question.

    Remember: 
    If it's considered a follow-up question, rephrase it. Otherwise, return it as is If it's not related to the previous question. 
    Don't answer the question and Don't reply to the user, you are only responsible for rephrase.
"""
    contextualize_q_prompt = ChatPromptTemplate.from_messages(
        [
            ("system", contextualize_q_system_prompt),
            MessagesPlaceholder("chat_history"),
            ("human", "{input}"),
        ]
    )

    return contextualize_q_prompt