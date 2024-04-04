from langchain_community.document_loaders import PyPDFLoader
import pickle


class PdfReader:
    def __init__(self) -> None:
        pass

    def read_pdf(filename, path):

        loader = PyPDFLoader(filename)
        pages = loader.load()
        for page_no in range(len(pages)):
            doc = pages[page_no]
            doc.page_content = doc.page_content.replace(u"\xa0", u" ")
            with open(path+str(page_no)+'.pkl', 'wb') as f:
                pickle.dump(doc, f)