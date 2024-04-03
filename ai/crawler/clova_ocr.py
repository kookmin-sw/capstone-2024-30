import requests
import json
import time
import uuid

class OCR:
  def __init__(self, secret_key, api_url):
    self.secret_key = secret_key
    self.api_url = api_url
    self.request_json = {'images': [{'format': 'jpg',
                            'name': 'demo'
                               }],
                    'requestId': str(uuid.uuid1()),
                    'version': 'V2',
                    'timestamp': int(round(time.time() * 1000))
                   }
    self.payload = {'message': json.dumps(self.request_json).encode('UTF-8')}
    self.headers = {
      'X-OCR-SECRET': self.secret_key,
    }
    self.sleep_time = 1

  def img_to_txt(self, img_url):
    headers = {'User-Agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36'}
    filename = "./tmp_image.jpg"
    #time.sleep(random.uniform(2,3))
    resp = requests.get(img_url, headers=headers, verify=False)
    if resp.status_code != 200:
      return ''
    
    with open(filename, "wb") as f:
        f.write(resp.content)
    files = [('file', open('./tmp_image.jpg','rb'))]
    #time.sleep(random.uniform(2,3))
    response = requests.request("POST", self.api_url, headers=self.headers, data=self.payload, files=files)
    res = response.json()
    return self.join_text(res)

  def img_lst_to_txt(self, img_url_lst):
    if not img_url_lst:
      return

    result = []
    for u in img_url_lst:
      t = self.img_to_txt(u)
      if t:
        result.append(t + '\n')

    return ''.join(result)

  def join_text(self, result):
    txt = ''
    if 'images' not in result.keys() or 'fields' not in result['images'][0].keys():
      return txt
    for img in result['images'][0]['fields']:
      txt += img['inferText']
      if img['lineBreak']:
        txt += '\n'
    return txt