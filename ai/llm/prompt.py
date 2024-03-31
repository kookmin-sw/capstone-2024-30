from langchain import PromptTemplate

def source_prompt():
    source_template = \
    """You are an assistant that outputs metadata corresponding to the following pieces of retrieved context. If there is no relevant data, you should output that there is no corresponding source.

    Question: {question}
    Context: {context}
    metadata:"""
    
    source_chain = PromptTemplate(input_variables=['question', 'context'], template = source_template)

    return source_chain

def final_prompt():
    final_template = \
    """You are an assistant that outputs completed responses by appropriately combining content and metadata. If you have metadata, be sure to include it in your answer. Moreover, you must generate responses in the language corresponding to the question.
    Question: {question}
    Content: {content}
    Metadata: {metadata}
    Answer:"""
    
    final_chain = PromptTemplate(input_variables=['content', 'metadata'], template = final_template)

    return final_chain