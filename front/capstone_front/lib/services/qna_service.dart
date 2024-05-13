import 'dart:convert';

import 'package:capstone_front/models/answer_model.dart';
import 'package:capstone_front/models/answer_response.dart';
import 'package:capstone_front/models/api_fail_response.dart';
import 'package:capstone_front/models/api_success_response.dart';
import 'package:capstone_front/models/qna_post_model.dart';
import 'package:capstone_front/models/qna_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

class QnaService {
  static String baseUrl = dotenv.get('BASE_URL');

  static Future<QnasResponse> getQnaPosts(
      int cursor, String? tag, String? word) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    final url = Uri.parse('$baseUrl/question/list');

    var requestInfo = {
      "cursorId": cursor,
      "tag": tag,
      "word": word,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(requestInfo),
    );

    List<QnaPostModel> qnaPostInstances = [];

    final String decodedBody = utf8.decode(response.bodyBytes);
    final jsonMap = jsonDecode(decodedBody);

    if (response.statusCode == 200) {
      final ApiSuccessResponse apiSuccessResponse =
          ApiSuccessResponse.fromJson(jsonMap);
      final res = apiSuccessResponse.response;
      final List<dynamic> posts = res['questionList'];

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

  static Future<QnaPostDetailModel> getQnaPostDetailById(int id) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    final url = Uri.parse('$baseUrl/question/read?id=$id');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final jsonMap = jsonDecode(decodedBody);

    if (response.statusCode == 200) {
      final ApiSuccessResponse apiSuccessResponse =
          ApiSuccessResponse.fromJson(jsonMap);
      final res = apiSuccessResponse.response;
      var qnaPostDetailModel = QnaPostDetailModel.fromJson(res);

      return qnaPostDetailModel;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load notices');
    }
  }

  static Future<AnswerResponse> getAnswersByQuestionId(
      Map<String, dynamic> obj) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    List<AnswerModel> answerInstances = [];
    final url = Uri.parse('$baseUrl/answer/list');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(obj),
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final jsonMap = jsonDecode(decodedBody);

    if (response.statusCode == 200) {
      final ApiSuccessResponse apiSuccessResponse =
          ApiSuccessResponse.fromJson(jsonMap);
      final res = apiSuccessResponse.response;
      final List<dynamic> answers = res['answerList'];
      for (var answer in answers) {
        answerInstances.add(AnswerModel.fromJson(answer));
      }

      var result = AnswerResponse(
        answers: answerInstances,
        lastCursorId: res['lastCursorId'],
        hasNext: res['hasNext'],
      );

      return result;
    } else {
      var apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with status: ${apiFailResponse.message}.');
      throw Exception('Failed to load notices');
    }
  }

  static Future<Map<String, dynamic>> createQnaPost(
      Map<String, dynamic> qnaPost, List<XFile>? images) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    // final url = Uri.parse('https://postman-echo.com/post');
    final url = Uri.parse('$baseUrl/question/create');

    var request = http.MultipartRequest('POST', url);

    // JSON 데이터를 UTF-8로 인코딩하여 바이트로 변환 후 MultipartFile로 추가
    List<int> jsonData = utf8.encode(jsonEncode(qnaPost));
    request.files.add(http.MultipartFile.fromBytes(
      'request',
      jsonData,
      contentType: MediaType(
        'application',
        'json',
        {'charset': 'utf-8'},
      ),
    ));

    // request.fields['request'] = jsonEncode(qnaPost);
    request.headers['Authorization'] = 'Bearer $accessToken';
    request.headers['Content-Type'] = 'multipart/form-data';

    if (images != null) {
      for (var image in images) {
        if (image.path.isNotEmpty) {
          var multipartFile = await http.MultipartFile.fromPath(
            'imgList',
            image.path,
          );
          request.files.add(multipartFile);
        }
      }
    }

    var response = await request.send();

    final bytes = await response.stream.toBytes();
    final String decodedBody = utf8.decode(bytes);
    final Map<String, dynamic> jsonMap = jsonDecode(decodedBody);
    if (response.statusCode == 200) {
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

  static Future<AnswerModel> createAnswer(Map<String, dynamic> answer) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    final url = Uri.parse('$baseUrl/answer/create');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(answer),
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final jsonMap = jsonDecode(decodedBody);

    if (response.statusCode == 200) {
      final ApiSuccessResponse apiSuccessResponse =
          ApiSuccessResponse.fromJson(jsonMap);
      final res = apiSuccessResponse.response;
      var answerModel = AnswerModel.fromJson(res);

      return answerModel;
    } else {
      var apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with status: ${apiFailResponse.message}.');
      throw Exception('Failed to load notices');
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
