import requests
from langchain.document_loaders import WebBaseLoader
import pickle
import bs4
from tqdm import tqdm
import re
from crawler.clova_ocr import OCR
import time
import random
import os

class NoticeCrawler:
  def __init__(self, secret_key, api_url):
    self.url = 'https://www.kookmin.ac.kr/user/kmuNews/notice/index.do?notcLwprtCatgrCd=&currentPageNo='
    self.notice_url = ['https://www.kookmin.ac.kr/user/kmuNews/notice/', '', '/', '', '/view.do?currentPageNo=' , ''] # 1, 3, 5
    self.title_lst = None
    self.date_time_lst = None
    self.ocr = OCR(secret_key, api_url)
    self.header =  {'User-Agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36'}
    self.sleeptime = 1

  def get_notice_list(self, page_no):
    #time.sleep(random.uniform(2,4))
    response = requests.get(self.url + str(page_no), headers=self.header, verify=False)
    
    # 응답의 상태코드를 확인
    if response.status_code == 200:
        # JSON 형식의 데이터를 가져옵니다.
        json_data = response.json()

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
    for lnk in tqdm(notice_url_lst):
      #time.sleep(random.uniform(2,3))
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
    #time.sleep(1)
    response = requests.get(url, headers=self.header, verify=False)

    # 응답의 상태코드를 확인
    if response.status_code == 200:
        json_data = response.json()
        string = json_data['result']['info']['noticeSntncCn']
        links = re.findall(r'https://kep.kookmin.ac.kr/com/cmsv/FileCtr/findUploadImg[^"\s]*', string)
        return links

    else:
        print("url error:", response.status_code)
        return []
  
  def Crawling_notice_page_to_page(self, start=1, end=194, path = './Notice/'):
    for page_no in range(start, end+1):
      #time.sleep(1)
      docs = self.crawling_notices_by_page(page_no)
      if not os.path.exists(path):
        os.makedirs(path)
      with open(path+'notice_'+str(page_no)+'.pkl', 'wb') as f:
        pickle.dump(docs, f)

      with open(path+'notice_count'+'.txt', 'w') as f:
        f.write(str(page_no+1))
        