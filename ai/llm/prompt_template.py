from langchain import PromptTemplate

template = \
"""You are an assistant for question-answering tasks. You should always answer the question in the language it is asked in. Use the following pieces of retrieved context to answer the question with source and url link of corresponding context. If you don't know the answer, just say that you don't know. Use three sentences maximum and keep the answer concise and you must include the source in metadata of relevant context if it exist.
Question: {question}
Context: {context}
Answer:
[translating corresponding language -> Source] : metadata here"""

def prompt_with_source(template = template):
    return PromptTemplate(input_variables=['context', 'question'], template = template)