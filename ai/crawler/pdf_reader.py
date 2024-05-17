from langchain_community.document_loaders import PyPDFLoader
import pickle
import os
from tqdm import tqdm

class PdfReader:
    def __init__(self) -> None:
        pass

    def read_pdf(self, filepath, path='./data/', name='default'):

        filename, _ = os.path.splitext(os.path.basename(filepath))
        path += filename + '/' + 'SCHOOL_INFO/'

        if not os.path.exists(path):
            os.makedirs(path)
        print(f'-- Load pdf file {filename} --')
        loader = PyPDFLoader(filepath)
        pages = loader.load()
        print('-- start --')
        total_pdf = []
        print(type(pages[0]))
        for page_no in tqdm(range(len(pages))):
            doc = pages[page_no]
            doc.page_content = doc.page_content.replace(u"\xa0", u" ")
            doc.page_content = doc.page_content.replace("·", "")
            if doc.page_content:
                total_pdf.append(doc)
        with open(path+name+'.pkl', 'wb') as f:
            pickle.dump(total_pdf, f)

tmp = PdfReader()
tmp.read_pdf('./2023+국민대학교+요람.pdf')