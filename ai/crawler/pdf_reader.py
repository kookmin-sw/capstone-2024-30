from langchain_community.document_loaders import PyPDFLoader
import pickle
import os

class PdfReader:
    def __init__(self) -> None:
        pass

    def read_pdf(self, filepath, path='./'):

        filename, _ = os.path.splitext(os.path.basename(filepath))
        path += filename + '/'

        if not os.path.exists(path):
            os.makedirs(path)

        loader = PyPDFLoader(filepath)
        pages = loader.load()
        for page_no in range(len(pages)):
            doc = pages[page_no]
            doc.page_content = doc.page_content.replace(u"\xa0", u" ")
            with open(path+'page'+str(page_no)+'.pkl', 'wb') as f:
                pickle.dump(doc, f)