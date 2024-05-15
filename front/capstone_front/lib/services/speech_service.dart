import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:capstone_front/models/speech_model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

Future<SpeechModel> getSpeechResult(String filePath, String sentence) async {
  String baseUrl = dotenv.get('BASE_URL');
  final url = Uri.parse('$baseUrl/speech/test');

  // Multipart request 생성
  var request = http.MultipartRequest('POST', url);

  request.headers['Content-Type'] = 'multipart/form-data';

  var file = File.fromUri(Uri.parse(filePath));
  // 오디오 파일 추가
  var audioStream = http.ByteStream(file.openRead());
  var audioLength = await file.length();
  var audioMultipartFile = http.MultipartFile('file', audioStream, audioLength,
      filename: 'sample.m4a');

  request.files.add(audioMultipartFile);

  // 문자열 데이터 추가
  var data = {
    'context': sentence,
  };

  // JSON 데이터를 UTF-8로 인코딩하여 바이트로 변환 후 MultipartFile로 추가
  List<int> jsonData = utf8.encode(jsonEncode(data));
  request.files.add(http.MultipartFile.fromBytes(
    'context',
    jsonData,
    contentType: MediaType(
      'application',
      'json',
      {'charset': 'utf-8'},
    ),
  ));

  // 요청 보내기
  var streamResponse = await request.send();
  var response = await http.Response.fromStream(streamResponse);

  var json = jsonDecode(utf8.decode(response.bodyBytes));
  print(json);
  // 응답 처리
  if (response.statusCode == 200) {
    print("success get speech result");

    return SpeechModel.fromJson(json['response']);
  } else {
    throw Exception('Failed');
  }

// ------------------------------------------

  // Map<String, dynamic> json = {
  //   "success": true,
  //   "message": "Successfully load score",
  //   "response": {
  //     "accuracyScore": 100.0,
  //     "paragraphCompleteness": 100.0,
  //     "completenessScore": 100.0,
  //     "text":
  //         "북한 중앙방송은 이날 시사논단에서 미국 국무부가 지난 달 말 발표한 인권보고서와 관련해 다른 나라의 인권에 대해 이러쿵 저러쿵 시비질을 하면서 마치 세계 인권재판관이라도 되는 듯이 행세하고 있다고 비난했다.",
  //     "fluencyScore": 99.0,
  //     "paragraphFluency": 99.0,
  //     "wordList": [
  //       {"errorType": "None", "word": "북한", "accuracy": 100.0},
  //       {"errorType": "None", "word": "북한", "accuracy": 100.0},
  //       {"errorType": "None", "word": "북한", "accuracy": 100.0},
  //     ],
  //     "pronunciationScore": 99.4,
  //     "paragraphAccuracy": 99.57142857142857
  //   }
  // };

  // Map<String, dynamic> json = {
  //   'accuracyScore': 100.0,
  //   'paragraphCompleteness': 100.0,
  //   'wordList': [
  //     {'word': '이번', 'accuracy': 100.0, 'errorType': 'None'},
  //     {'word': '주말에', 'accuracy': 0.0, 'errorType': 'Omission'},
  //     {'word': '시간', 'accuracy': 100.0, 'errorType': 'None'},
  //     {'word': '시간', 'accuracy': 100.0, 'errorType': 'Insertion'},
  //     {'word': '있어', 'accuracy': 100.0, 'errorType': 'None'},
  //     {'word': '같이', 'accuracy': 100.0, 'errorType': 'None'},
  //     {'word': '공부하자', 'accuracy': 100.0, 'errorType': 'None'}
  //   ],
  //   'completenessScore': 100.0,
  //   'text': '이번 학기에 어떤 과목 듣고 있어?',
  //   'fluencyScore': 100.0,
  //   'paragraphFluency': 100.0,
  //   'pronunciationScore': 100.0,
  //   'paragraphAccuracy': 100.0
  // };

  // SpeechModel a = SpeechModel.fromJson(json);

  // await Future.delayed(const Duration(seconds: 2));
  // return SpeechModel.fromJson(json);
}
