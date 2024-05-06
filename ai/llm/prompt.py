from langchain import PromptTemplate
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder

def casual_prompt():
    prompt = PromptTemplate.from_template(
    """
    question: {question}
    answer:"""
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
    You are an assistant for question-answering tasks. Use the following informations of 'notice_info' and 'school_info' to answer the question.  If you don't know the answer, just say that you don't know. Include as much of the provided information as possible.
    Question: {question}
    Notice_info: {notice_info}
    School_info: {school_info}
    Answer:"""
    )
    return prompt

def score_prompt():
    prompt = PromptTemplate.from_template("""
    I am a student at Kookmin University. Given a question-answer pair, you need to respond whether the answer to the question is "good" or "bad". Also, even if you cannot answer, you must respond as 'bad'. Do not respond with more than one word.

    question: {question}
    answer: {answer}

    Classification:"""
    )
    return prompt

def contextualize_prompt():

    contextualize_q_system_prompt = """Given a chat history and the latest user question \
    which might reference context in the chat history, formulate a standalone question \
    which can be understood without the chat history. Do NOT answer the question, \
    just reformulate it if needed and otherwise return it as is.\n

    ex1) 
    HUMAN : What is Task Decomposition? 
    AI : Task decomposition is a technique used to break down complex tasks into smaller and simpler steps. This approach helps agents or models handle difficult tasks by dividing them into more manageable subtasks. It can be achieved through methods like Chain of Thought (CoT) or Tree of Thoughts, which guide the model in thinking step by step or exploring multiple reasoning possibilities at each step.
    HUMAN(latest user question) : What are common ways of doing it?
    REFORMULATE QUESTION(your response) : What are common ways of doing Task Decomposition?
"""
    contextualize_q_prompt = ChatPromptTemplate.from_messages(
        [
            ("system", contextualize_q_system_prompt),
            MessagesPlaceholder("chat_history"),
            ("human", "{input}"),
        ]
    )

    return contextualize_q_prompt