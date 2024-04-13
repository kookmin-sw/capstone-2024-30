import bs4
from langchain.document_loaders import WebBaseLoader
import requests
import pickle
import os
from tqdm import tqdm

class CissClawer:
    def __init__(self, urls_txt='./crawler/ciss_url.txt'):
        self.urls = self.load_urls_from_file(urls_txt)
        self.static_urls = self.urls[:29] # 그 외
        self.notice_urls = self.urls[29:] # 공지사항
        self.notice_categories = ['academic', 'visa', 'scholarship', 'event', 'program', 'gks']

    def load_urls_from_file(self, file_path='./ciss_url.txt'):
        urls = []
        with open(file_path, 'r') as file:
            for line in file:
                url = line.strip()  # 줄 바꿈 문자 제거
                if url:  # 비어있지 않은 줄만 추가
                    urls.append(url)
        return urls
    
    def crawling_content_url(self, urls_lst):
        loader = WebBaseLoader(
            web_paths=(urls_lst),
            bs_kwargs=dict(
                parse_only=bs4.SoupStrainer(
                    class_=("content-wrap")
                )
            ),
        )

        docs = loader.load()
        metadata_lst = self.extract_page_metadata(urls_lst)

        for i, doc in enumerate(tqdm(docs)):
            doc.page_content = doc.page_content.replace(u"\xa0", u" ")
            try:
                doc.metadata['title'] = metadata_lst[i][0]
                if len(metadata_lst[i]) >= 2:
                    doc.metadata['datetime'] = metadata_lst[i][1]
            except:
                print(f'ERROR ! : {urls_lst[i], metadata_lst[i]}')
            
        return docs
    

    def crawling(self, path = './CISS/'):
        print(f' crawling CISS notice ... ')
        notice_path = path + 'NOTICE/'
        for i, url in enumerate(self.notice_urls):
            print(f' crawling {self.notice_categories[i]} ... ')
            child_url_lst = self.get_notice_child_urls(url)

            docs = self.crawling_content_url(child_url_lst)
            if not os.path.exists(notice_path):
                os.makedirs(notice_path)
            with open(notice_path+self.notice_categories[i]+'.pkl', 'wb') as f:
                pickle.dump(docs, f)
        
        non_notice_path = path + 'SCHOOL_INFO/'
        print(f' crawling CISS non_notice ... ')
        docs = self.crawling_content_url(self.static_urls)

        if not os.path.exists(non_notice_path):
            os.makedirs(non_notice_path)
        with open(non_notice_path+'non_notice'+'.pkl', 'wb') as f:
            pickle.dump(docs, f)

    def get_notice_child_urls(self, notice_categori_url):
        href_values = []
        base_url = notice_categori_url.split('?')[0]

        try:
            # 페이지 가져오기
            response = requests.get(notice_categori_url)
            response.raise_for_status()

            # HTML 파싱
            soup = bs4.BeautifulSoup(response.text, 'html.parser')

            # 지정된 클래스를 가진 요소 추출
            boxes = soup.find_all(class_='b-title-box')

            # 각 박스에서 하위 <a> 태그의 href 속성 값 추출
            for box in boxes:
                links = box.find_all('a', href=True)
                for link in links:
                    href_values.append(base_url + link['href'])

        except Exception as e:
            print(f"Error processing URL '{notice_categori_url}': {e}")

        return href_values
    
    def extract_page_metadata(self, urls):
        results = []  # 각 url들의 title이 담길 list
        for url in urls:
            try:
                # 페이지 가져오기
                response = requests.get(url)
                response.raise_for_status()  # 오류가 발생하면 예외를 일으킴
                # HTML 파싱
                soup = bs4.BeautifulSoup(response.text, 'html.parser')
                # 클래스가 'page-title'인 요소 추출
                page_title_elements = soup.find_all(class_= ['page-title', 'b-date-box'])
                # 결과 리스트에 추가
                page_titles = [element.text.strip() for element in page_title_elements]
                results.append(page_titles)

            except Exception as e:
                print(f"Error processing URL '{url}': {e}")

        return results


if __name__ == '__main__':
    def change_working_directory_to_script_location():
        # 현재 스크립트의 디렉토리 경로를 얻기
        script_directory = os.path.dirname(__file__)

        # 현재 스크립트의 디렉토리로 작업 디렉토리 변경
        os.chdir(script_directory)

        # 변경된 작업 디렉토리 반환
        return os.getcwd()
    
    # 함수 호출하여 작업 디렉토리 변경
    new_working_directory = change_working_directory_to_script_location()

    # 현재 작업 디렉토리 출력
    current_working_directory = os.getcwd()
    print("Current working directory:", current_working_directory)
    urls_txt = 'url_path'
    cc = CissClawer(urls_txt)
    cc.crawling()