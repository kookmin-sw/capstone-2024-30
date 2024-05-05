import deepl

class DeeplTranslator:
    def __init__(self):
        API_KEY = 'd31a50f4-1d48-4f54-bbad-c6c63cdcffb3:fx'
        self.translator = deepl.Translator(API_KEY)

    def fuck(self, message):
        result = self.translator.translate_text(message, 'ko')
        return result.text
    

if __name__ == '__main__':
    dl = DeeplTranslator()
    dl.fuck()