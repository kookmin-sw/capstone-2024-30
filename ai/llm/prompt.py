from langchain import PromptTemplate

def casual_prompt():
    prompt = PromptTemplate.from_template(
    """
    question: {question}
    answer:"""
    )
    return prompt

def is_qna_prompt():
    prompt = PromptTemplate.from_template(
    """Given the user input below, classify it as either being about `question`, `casual` or 'other'.
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

def translate_prompt():
    prompt = PromptTemplate.from_template("""
    You are a translator with vast knowledge of human languages. Translate the content into the language corresponding to the question. You should only translate and never answer questions.
        
    question : {question}
    content : {content}
    result :""")
    return prompt