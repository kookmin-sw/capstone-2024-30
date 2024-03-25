import requests
from langchain.document_loaders import WebBaseLoader
from langchain.docstore.document import Document
import bs4
from tqdm import tqdm
import re
from clova_ocr import OCR

class NoticeCrawler:
  def __init__(self, secret_key, api_url):
    self.url = 'https://www.kookmin.ac.kr/user/kmuNews/notice/index.do?notcLwprtCatgrCd=&currentPageNo='
    self.notice_url = ['https://www.kookmin.ac.kr/user/kmuNews/notice/', '', '/', '', '/view.do?currentPageNo=' , ''] # 1, 3, 5
    self.title_lst = None
    self.date_time_lst = None
    self.ocr = OCR(secret_key, api_url)

  def get_notice_list(self, page_no):
    response = requests.get(self.url + str(page_no))
    
    # 응답의 상태코드를 확인
    if response.status_code == 200:
        # JSON 형식의 데이터를 가져옵니다.
        json_data = response.json()
        #print(json_data['result']['list'])

    else:
        print("url error:", response.status_code)
        return []
    
    notice_url_lst = []
    title_lst= []
    date_time_lst = []

    self.notice_url[5] = str(page_no)

    for item in json_data['result']['list']:
      self.notice_url[1] = str(item['notcCatgrCd'])
      self.notice_url[3] = str(item['notcNo'])
      notice_url_lst.append(''.join(self.notice_url))

      title_lst.append(item['notcTitle'])
      date_time_lst.append(item['frstInputDttm'])

    self.title_lst = title_lst
    self.date_time_lst = date_time_lst

    return notice_url_lst

  def crawling_notices_by_page(self, page_no):
    notice_url_lst = self.get_notice_list(page_no)
    docs = []
    print(f"\n ... start crawling = page_no: {page_no}, {len(notice_url_lst)} pages ...")
    for lnk in tqdm(notice_url_lst):
      loader = WebBaseLoader(
          web_paths=([lnk]),
          bs_kwargs=dict(
              parse_only=bs4.SoupStrainer(
                  class_=("view_tit","view_cont")
                  )
              ),
          encoding='utf-8'
          )
      doc = loader.load()
      doc[0].page_content = doc[0].page_content.replace(u"\xa0", u" ")
      img_txt = self.ocr.img_lst_to_txt(self.get_img_url_list(lnk))
      if img_txt:
        doc[0].page_content += '\n'+img_txt
      docs.append(doc[0])

    for i, doc in enumerate(docs):
      doc.metadata['title'] =  self.title_lst[i]
      doc.metadata['datetime'] = self.date_time_lst[i]

    return docs
  
  def get_img_url_list(self, url):
    response = requests.get(url)

    # 응답의 상태코드를 확인
    if response.status_code == 200:
        json_data = response.json()
        string = json_data['result']['info']['noticeSntncCn']
        links = re.findall(r'(https?://\S+?)(?=")', string)

        return links

    else:
        print("url error:", response.status_code)
        return []