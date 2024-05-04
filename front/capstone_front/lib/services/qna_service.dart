import 'dart:convert';

import 'package:capstone_front/models/answer_model.dart';
import 'package:capstone_front/models/api_fail_response.dart';
import 'package:capstone_front/models/api_success_response.dart';
import 'package:capstone_front/models/qna_post_model.dart';
import 'package:capstone_front/models/qna_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class QnaService {
  static String baseUrl = dotenv.get('BASE_URL');

  static Future<QnasResponse> getQnaPosts(int cursor, String type) async {
    var query = 'type=$type&cursor=$cursor';
    final url = Uri.parse('$baseUrl/yet?$query');
    final response = await http.get(url);

    List<QnaPostModel> qnaPostInstances = [];

    final String decodedBody = utf8.decode(response.bodyBytes);
    final jsonMap = jsonDecode(decodedBody);
    if (response.statusCode == 200) {
      final ApiSuccessResponse apiSuccessResponse = jsonDecode(jsonMap);
      final res = apiSuccessResponse.response;
      final List<dynamic> posts = res['qnas'];

      for (var post in posts) {
        qnaPostInstances.add(QnaPostModel.fromJson(post));
      }

      var result = QnasResponse(
        qnas: qnaPostInstances,
        lastCursorId: res['lastCursorId'],
        hasNext: res['hasNext'],
      );

      return result;
    } else {
      ApiFailResponse apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with status: ${apiFailResponse.message}.');
      throw Exception('Failed to load notices');
    }
  }

  static Future<List<AnswerModel>> getAnswersByQuestionId(int qnaPostId) async {
    List<AnswerModel> answerInstances = [];
    final url = Uri.parse('$baseUrl/yet/$qnaPostId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final List<dynamic> answers = jsonDecode(decodedBody);

      for (var answer in answers) {
        answerInstances.add(AnswerModel.fromJson(answer));
      }
      return answerInstances;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load notices');
    }
  }

  static Future<Map<String, dynamic>> createQnaPost(
      Map<String, dynamic> qnaPost, List<XFile>? images) async {
    // final url = Uri.parse('https://postman-echo.com/post');
    final url = Uri.parse('$baseUrl/question/create');

    var request = http.MultipartRequest('POST', url);
    request.fields['request'] = jsonEncode(qnaPost);

    if (images != null) {
      for (var image in images) {
        if (image.path.isNotEmpty) {
          print(image.path);
          var multipartFile = await http.MultipartFile.fromPath(
            'imgList',
            image.path,
          );
          request.files.add(multipartFile);
        }
      }
    }

    // request.headers.addAll({
    //   'Content-Type': 'multipart/form-data',
    // });

    var response = await request.send();

    final bytes = await response.stream.toBytes();
    final String decodedBody = utf8.decode(bytes);
    logToFile(decodedBody);

    print(decodedBody);

    final Map<String, dynamic> jsonMap = jsonDecode(decodedBody);
    if (response.statusCode == 201) {
      // TODO 게시글 id 리턴받아서, 게시글 객체 완성한 다음에 리스트에 추가 및 띄워주기
      ApiSuccessResponse apiSuccessResponse =
          ApiSuccessResponse.fromJson(jsonMap);
      Map<String, dynamic> resMap = apiSuccessResponse.response;

      return resMap;
    } else {
      ApiFailResponse apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with status: ${apiFailResponse.message}.');
      throw Exception("cant post article");
    }
  }

  static void logToFile(String data) async {
    final file = File('./logfile.txt'); // 적절한 파일 경로 설정
    await file.writeAsString(data, mode: FileMode.append);
  }

  static Future<bool> createAnswer(AnswerModel answer) async {
    final url = Uri.parse('$baseUrl/yet/');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(answer.toJson()),
    );

    if (response.statusCode == 201) {
      // post 요청 성공시
      return true;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

  static Future<QnasResponse> searchQnaPosts(String query) async {
    final url = Uri.parse('$baseUrl/yet/search?q=$query');
    final response = await http.get(url);

    List<QnaPostModel> qnaPostInstances = [];

    final String decodedBody = utf8.decode(response.bodyBytes);
    final jsonMap = jsonDecode(decodedBody);

    if (response.statusCode == 200) {
      final apiSuccessResponse = ApiSuccessResponse.fromJson(jsonMap);
      final resMap = apiSuccessResponse.response;
      final posts = resMap['posts'];

      for (var post in posts) {
        qnaPostInstances.add(QnaPostModel.fromJson(post));
      }

      var result = QnasResponse(
        qnas: qnaPostInstances,
        lastCursorId: jsonMap['lastCursorId'],
        hasNext: jsonMap['hasNext'],
      );

      return result;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load QnA posts');
    }
  }

  static Future<bool> toggleLike(int commentId) async {
    final url = Uri.parse('$baseUrl/yet/commentLike');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "commentId": commentId,
      }),
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final jsonMap = jsonDecode(decodedBody);

    if (response.statusCode == 200) {
      var apiSuccessResponse = jsonDecode(jsonMap);

      return true;
    } else {
      var apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with status: ${apiFailResponse.message}.');
      throw Exception('Failed to load notices');
    }
  }
}
