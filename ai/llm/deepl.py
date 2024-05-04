import deepl

class DeepL:
    def __init__(self):
        API_KEY = 'd31a50f4-1d48-4f54-bbad-c6c63cdcffb3:fx'
        self.translator = deepl.Translator(API_KEY)

    def translate(self, message, target_lang='ko'):
        result = self.translator.translate_text(message, target_lang)
        return result.text