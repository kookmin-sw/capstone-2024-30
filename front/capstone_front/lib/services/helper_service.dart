import 'dart:convert';

import 'package:capstone_front/models/answer_model.dart';
import 'package:capstone_front/models/api_fail_response.dart';
import 'package:capstone_front/models/api_success_response.dart';
import 'package:capstone_front/models/helper_article_model.dart';
import 'package:capstone_front/models/helper_article_preview_model.dart';
import 'package:capstone_front/models/helper_article_response.dart';
import 'package:capstone_front/models/qna_post_model.dart';
import 'package:capstone_front/models/qna_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class HelperService {
  static String baseUrl = dotenv.get('BASE_URL');

  static Future<HelperArticleResponse> getHelperAtricles(
      int cursor, bool? isHelper, bool? isDone, String? uuid) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    final url = Uri.parse('$baseUrl/help/list');

    var requestInfo = {
      "cursorId": cursor,
      "isDone": isDone,
      "isHelper": isHelper,
      "isMine": uuid
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(
        requestInfo,
      ),
    );

    List<HelperArticlePreviewModel> helperArticlePreviewInstances = [];

    final String decodedBody = utf8.decode(response.bodyBytes);
    final jsonMap = jsonDecode(decodedBody);
    if (response.statusCode == 200) {
      final ApiSuccessResponse apiSuccessResponse =
          ApiSuccessResponse.fromJson(jsonMap);
      final res = apiSuccessResponse.response;
      final List<dynamic> posts = res['helpList'];

      for (var post in posts) {
        helperArticlePreviewInstances
            .add(HelperArticlePreviewModel.fromJson(post));
      }

      var result = HelperArticleResponse(
        articles: helperArticlePreviewInstances,
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

  static Future<HelperArticleModel> getDetailById(int atricleId) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    List<AnswerModel> answerInstances = [];
    final url = Uri.parse('$baseUrl/help/read?id=$atricleId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> jsonMap = jsonDecode(decodedBody);

    if (response.statusCode == 200) {
      var apiSuccessResponse = ApiSuccessResponse.fromJson(jsonMap);
      var detail = HelperArticleModel.fromJson(apiSuccessResponse.response);

      return detail;
    } else {
      var apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print(apiFailResponse.message);
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load noticeDetail');
    }
  }

  static Future<HelperArticleModel> createHelperPost(
      Map<String, dynamic> helperPost) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    final url = Uri.parse('$baseUrl/help/create');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(helperPost),
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final jsonMap = jsonDecode(decodedBody);
    if (response.statusCode == 200) {
      // post 요청 성공시
      var apiSuccessResponse = ApiSuccessResponse.fromJson(jsonMap);
      var helperArticleModel =
          HelperArticleModel.fromJson(apiSuccessResponse.response);

      return helperArticleModel;
    } else {
      var apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with status: ${apiFailResponse.message}.');
      throw ('fail to post article');
    }
  }

  // @@@@@ 이하 QnA 복붙 @@@@@

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

  static Future<bool> completeRecruitment(int articleId) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    final url = Uri.parse('$baseUrl/help/done?id=$articleId');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final jsonMap = jsonDecode(decodedBody);
    if (response.statusCode == 200) {
      return true;
    } else {
      var apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with status: ${apiFailResponse.message}.');
      throw ('fail to put article');
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
