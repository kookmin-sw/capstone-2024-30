import bs4
from langchain.document_loaders import WebBaseLoader
import requests
import pickle
import os
from tqdm import tqdm

class SoftwareCrawler:
    def __init__(self, urls_txt = './crawler/sw_url.txt'):
        self.urls = self.load_urls_from_file(urls_txt)
        self.static_urls = self.urls[:-4]
        self.notice_urls = self.urls[-4:]

        self.notice_categories = {'notice':self.notice_urls[0], 
                                  'jobs':self.notice_urls[1],
                                  'scholarship':self.notice_urls[2],
                                  'event':self.notice_urls[3]}
        
        self.crawling_range = {'notice':(1971, 2413),
                                      'jobs':(1530, 1642),
                                      'scholarship':(85, 86),
                                      'event':(1113, 1207)}
    
    def load_urls_from_file(self, file_path='./ciss_url.txt'):
        urls = []
        with open(file_path, 'r') as file:
            for line in file:
                url = line.strip()  # 줄 바꿈 문자 제거
                if url:  # 비어있지 않은 줄만 추가
                    urls.append(url)
        return urls
    
    def crawling_content_url(self, urls_lst, page_type=None):
        loader = WebBaseLoader(
            web_paths=(urls_lst),
            bs_kwargs=dict(
                parse_only=bs4.SoupStrainer(
                    id='content'
                )
            ),
        )

        docs = loader.load()
        if page_type == 'notice':
            metadata_lst = self.extract_notice_metadata(urls_lst)
        else:
            metadata_lst = self.extract_static_metadata(urls_lst)

        for i, doc in enumerate((tqdm(docs))):
            doc.page_content = doc.page_content.replace(u"\xa0", u" ")
            doc.metadata['title'] = metadata_lst[i][0]
            if page_type == 'notice':
                doc.metadata['datetime'] = metadata_lst[i][1]
        
        return docs
    
    def notice_url_lst(self, categori):
        start = self.crawling_range[categori][0]
        end = self.crawling_range[categori][1]+1
        url_lst = []
        base_url = self.notice_categories[categori]
        for i in range(start, end):
            tmp_url = base_url + '/' + str(i)
            response = requests.get(tmp_url)
            try:
                response.raise_for_status()  # 오류가 발생하면 예외를 일으킴
            except:
                continue

            # HTML 파싱
            soup = bs4.BeautifulSoup(response.text, 'html.parser')
            td_elements = soup.find_all('td')
            try:
                test = td_elements[1]
                url_lst.append(tmp_url)
            except:
                print(f'not valid url : {tmp_url}')
            
        return url_lst

    def crawling(self, path='./SW/'):

        if not os.path.exists(path):
            os.makedirs(path)

        docs = self.crawling_content_url(self.static_urls)
        with open(path+'non_notice'+'.pkl', 'wb') as f:
            pickle.dump(docs, f)
        
        notice_categories = self.notice_categories.keys()
        for c in notice_categories:
            docs = self.crawling_content_url(self.notice_url_lst(c), page_type='notice')
            with open(path+'sw_'+c+'.pkl', 'wb') as f:
                pickle.dump(docs, f)

    def extract_static_metadata(self, urls):
        results = []  # 결과를 저장할 리스트
        for i, url in enumerate(urls):
            try:
                # 페이지 가져오기
                response = requests.get(url)
                response.raise_for_status()  # 오류가 발생하면 예외를 일으킴
                # HTML 파싱
                soup = bs4.BeautifulSoup(response.text, 'html.parser')
                # 클래스가 'page-title'인 요소 추출
                page_title_elements = soup.find_all(class_= 'page-title')
                # 결과 리스트에 추가
                page_titles = ['소프트웨어학부 ' + page_title_elements[0].text.strip()]
                results.append(page_titles)
            except Exception as e:
                print(f"Error processing URL 'idx{i} {url}': {e}")
                if i == 5:
                    results.append('멘토링 시스템')
                    print('successfully handle exception! : 멘토링 시스템')
                elif i == 20:
                    results.append('일반대학원 입학')
                    print('successfully handle exception! : 일반대학원 입학')

        return results
    
    def extract_notice_metadata(self, urls):
        result = []
        for url in urls:
            try:
                # 페이지 가져오기
                response = requests.get(url)
                response.raise_for_status()  # 오류가 발생하면 예외를 일으킴

                # HTML 파싱
                soup = bs4.BeautifulSoup(response.text, 'html.parser')

                # 'view-title' 클래스를 가진 요소 찾기
                view_title_elements = soup.find_all(class_='view-title')
                view_titles = [element.text.strip() for element in view_title_elements]

                # 'article-subject' 클래스를 가진 요소 찾기
                article_subject_element = soup.find(class_='aricle-subject')

                # 'article-subject' 클래스 아래에 있는 <td> 태그의 값 추출
                td_values = []
                if article_subject_element:
                    td_elements = article_subject_element.find_all_next('td')
                    for td_element in td_elements:
                        td_values.append(td_element.text.strip())

                result.append(view_titles + td_values)

            except Exception as e:
                print(f"Error processing URL '{url}': {e}")
                result.append('None', 'None')

        return result