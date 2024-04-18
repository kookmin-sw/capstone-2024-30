import 'dart:convert';

import 'package:capstone_front/models/answer_model.dart';
import 'package:capstone_front/models/qna_post_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class QnaService {
  static String baseUrl = dotenv.get('BASE_URL');

  static Future<List<QnaPostModel>> getQnaPosts() async {
    List<QnaPostModel> qnaPostInstances = [];
    final url = Uri.parse('$baseUrl/yet/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final List<dynamic> posts = jsonDecode(decodedBody);

      for (var post in posts) {
        qnaPostInstances.add(QnaPostModel.fromJson(post));
      }
      return qnaPostInstances;
    } else {
      print('Request failed with status: ${response.statusCode}.');
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

  static Future<bool> createQnaPost(QnaPostModel qnaPost) async {
    final url = Uri.parse('$baseUrl/yet/');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(qnaPost.toJson()),
    );

    if (response.statusCode == 201) {
      // post 요청 성공시
      return true;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
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
}
