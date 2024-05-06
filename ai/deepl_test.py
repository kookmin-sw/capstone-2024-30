import deepl

auth_key = 'd31a50f4-1d48-4f54-bbad-c6c63cdcffb3:fx'
translator = deepl.Translator(auth_key)

message = '안녕하세요. 맛있는 점심 드세요~'
result = translator.translate_text(message, target_lang='KO')

print(result.text)