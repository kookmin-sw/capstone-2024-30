import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> getSpeechResult(String fileURI, String sentence) async {
  String baseUrl = dotenv.get('BASE_URL');
  final url = Uri.parse('$baseUrl/speech/test');

  var file = File(fileURI);

  // Multipart request 생성
  var request = http.MultipartRequest('POST', url);

  // 오디오 파일 추가
  var audioStream = http.ByteStream(file.openRead());
  var audioLength = await file.length();
  var audioMultipartFile = http.MultipartFile('file', audioStream, audioLength,
      filename: 'speech_file.mp4');

  request.files.add(audioMultipartFile);
  print(audioLength);

  // 문자열 데이터 추가
  var data = {'context': sentence};
  request.fields.addAll(data);

  // 요청 보내기
  var response = await request.send();
  print("resposne success");

  // 응답 처리
  if (response.statusCode == 200) {
    print('Uploaded!');
  } else {
    print('Failed with status code: ${response.statusCode}');
  }
  throw Exception('Failed to load speech');
}
