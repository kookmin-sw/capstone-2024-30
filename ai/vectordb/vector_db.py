from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.document_loaders import WebBaseLoader, TextLoader, PyPDFLoader, CSVLoader
from langchain_community.vectorstores import FAISS
from langchain_openai import OpenAIEmbeddings
import pickle
import os

class VectorDB:
    def __init__(self, api_key=None,):
        if api_key:
            os.environ['OPENAI_API_KEY'] = api_key
        self.embedding=OpenAIEmbeddings()
        self.vectorstore = None

    def add_content(self, content, vector_db_path='./'): # url, txt, pdf, csv 또는 string 만 가능

        self.load_local(vector_db_path)

        text_splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=100)
        if content.startswith('https:'):
            loader = WebBaseLoader(content)
        elif content.endswith('.txt'):
            loader = TextLoader(content)
        elif content.endswith('.pdf'):
            loader = PyPDFLoader(content)
        elif content.endswith('.csv'):
            loader = CSVLoader(content)
        elif content.endswith('.pkl'):
            with open(content, 'rb') as f:
                loaded_data = pickle.load(f)
                if type(loaded_data) != list:
                    loaded_data = [loaded_data]
                splits = text_splitter.split_documents(loaded_data)
                if splits:
                    FAISS.add_documents(self.vectorstore, splits)
                
                self.save_local(vector_db_path)
            return
        else:
            splits = text_splitter.split_text(content)
            if splits:
                FAISS.add_texts(self.vectorstore, splits)
            return
        
        docs = loader.load()
        text_splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=100)
        splits = text_splitter.split_documents(docs)
        FAISS.add_documents(self.vectorstore, splits)

        self.save_local(vector_db_path)

    def save_local(self, path=''):
        FAISS.save_local(self.vectorstore, path)

    def load_local(self, path=''):
        try:
            self.vectorstore = FAISS.load_local(path, self.embedding, allow_dangerous_deserialization=True)
        except:
            print(' === Create new vectorDB === ')
            self.vectorstore = FAISS.from_texts(' ', self.embedding)
            
    def similarity_search(self, query, k=1):
        return self.vectorstore.similarity_search(query, k)[0].page_content

    def get_retriever(self, k=2):
        return self.vectorstore.as_retriever(search_kwargs={"k": k})
