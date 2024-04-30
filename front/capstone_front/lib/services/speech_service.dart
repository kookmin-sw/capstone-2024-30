import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getSpeechResult(String filePath, String sentence) async {
  String baseUrl = dotenv.get('BASE_URL');
  final url = Uri.parse('$baseUrl/speech/test');

  // Multipart request 생성
  var request = http.MultipartRequest('POST', url);

  // -----------------
  // assets 폴더 내의 파일을 로드합니다.
  // ByteData dataa = await rootBundle.load('assets/audio/sample.wav');
  // List<int> bytes = dataa.buffer.asUint8List();

  // // 임시 파일을 생성하여 데이터를 기록합니다.
  // Directory tempDir = await getTemporaryDirectory();
  // String tempPath = tempDir.path;
  // String filePath = '$tempPath/sample.wav}';
  // File file = File(filePath);
  // await file.writeAsBytes(bytes);

  // -----------------

  var file = File(filePath);
  // 오디오 파일 추가
  var audioStream = http.ByteStream(file.openRead());
  var audioLength = await file.length();
  var audioMultipartFile = http.MultipartFile('file', audioStream, audioLength,
      filename: 'sample.pcm');

  request.files.add(audioMultipartFile);
  print(audioStream);

  // 문자열 데이터 추가
  var data = {
    'context': sentence,
  };
  request.fields.addAll(data);

  // 요청 보내기
  var streamResponse = await request.send();
  var response = await http.Response.fromStream(streamResponse);

  var json = jsonDecode(utf8.decode(response.bodyBytes));

  print("resposne success");

  // 응답 처리
  if (response.statusCode == 200) {
    print('Uploaded!');
    print(json);
    return "success";
  } else {
    print('Failed with status code: ${response.statusCode}');
    print(json);
    return "${response.statusCode}";
  }
}
