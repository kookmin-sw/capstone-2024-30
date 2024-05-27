import urllib.request
from dotenv import load_dotenv
import json
import os

load_dotenv()

class Papago:
    def __init__(self) -> None:
        self.client_id = os.getenv("PAPAGO_ID")
        self.client_secret = os.getenv("PAPAGO_API_KEY")

    def translate_text(self, text, target_lang='ko'):
        encText = urllib.parse.quote(text)
        source = self.detection_lang(text)
        if source == target_lang:
            return text
        target = target_lang
        data = f"source={source}&target={target}&text=" + encText
        url = "https://naveropenapi.apigw.ntruss.com/nmt/v1/translation"
        request = urllib.request.Request(url)
        request.add_header("X-NCP-APIGW-API-KEY-ID",self.client_id)
        request.add_header("X-NCP-APIGW-API-KEY",self.client_secret)
        response = urllib.request.urlopen(request, data=data.encode("utf-8"))
        rescode = response.getcode()
        if(rescode==200):
            response_body = response.read()
            json_str = response_body.decode('utf-8')
            dict_obj = json.loads(json_str)
            return dict_obj['message']['result']['translatedText']
        else:
            print("Error Code:" + rescode)
            return
    
    def detection_lang(self, text):
        encQuery = urllib.parse.quote(text)
        data = "query=" + encQuery
        url = "https://naveropenapi.apigw.ntruss.com/langs/v1/dect"
        request = urllib.request.Request(url)
        request.add_header("X-NCP-APIGW-API-KEY-ID",self.client_id)
        request.add_header("X-NCP-APIGW-API-KEY",self.client_secret)
        response = urllib.request.urlopen(request, data=data.encode("utf-8"))
        rescode = response.getcode()
        if(rescode==200):
            response_body = response.read()
            json_str = response_body.decode('utf-8')
            dict_obj = json.loads(json_str)
            return dict_obj['langCode']
        else:
            print("Error Code:" + rescode)

if __name__ == '__main__':
    pg = Papago()
    txt = pg.translate_text('안녕')
    print(txt)