import 'dart:convert';

import 'package:capstone_front/models/api_fail_response.dart';
import 'package:capstone_front/models/api_success_response.dart';
import 'package:capstone_front/models/notice_model.dart';
import 'package:capstone_front/models/notice_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NoticeService {
  static String baseUrl = dotenv.get('BASE_URL');

  static Future<NoticesResponse> getNotices(
      int cursor, String type, String language) async {
    var query = 'type=$type&language=$language&cursor=$cursor';
    final url = Uri.parse('$baseUrl/announcement?$query');
    final response = await http.get(url);

    List<NoticeModel> noticeInstances = [];

    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> jsonMap = jsonDecode(decodedBody);
    if (response.statusCode == 200) {
      var apiSuccessResponse = ApiSuccessResponse.fromJson(jsonMap);
      var res = apiSuccessResponse.response;
      var notices = res['announcements'];

      for (var notice in notices) {
        noticeInstances.add(NoticeModel.fromJson(notice));
      }

      var result = NoticesResponse(
        notices: noticeInstances,
        lastCursorId: res['lastCursorId'],
        hasNext: res['hasNext'],
      );

      return result;
    } else {
      var apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print(apiFailResponse.message);
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load notices');
    }
  }

  static Future<NoticeModel> getNoticeDetailById(int id) async {
    final url = Uri.parse('$baseUrl/announcement/$id');

    final response = await http.get(url);
    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> jsonMap = jsonDecode(decodedBody);

    if (response.statusCode == 200) {
      var apiSuccessResponse = ApiSuccessResponse.fromJson(jsonMap);
      var detail = NoticeModel.fromJson(apiSuccessResponse.response);

      return detail;
    } else {
      var apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print(apiFailResponse.message);
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load noticeDetail');
    }
  }
}
