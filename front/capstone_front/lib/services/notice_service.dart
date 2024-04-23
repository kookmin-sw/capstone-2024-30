import 'dart:convert';

import 'package:capstone_front/models/notice_model.dart';
import 'package:capstone_front/models/notice_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NoticeService {
  static String baseUrl = dotenv.get('BASE_URL');

  static Future<NoticesResponse> getNotices(int cursor) async {
    var type = 'all';
    var language = 'KO';
    var query = 'type=$type&language=$language&cursor=$cursor';
    final url = Uri.parse('$baseUrl/announcement?$query');
    final response = await http.get(url);

    List<NoticeModel> noticeInstances = [];

    if (response.statusCode == 200) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonData = jsonDecode(decodedBody);
      final List<dynamic> notices = jsonData['announcements'];

      for (var notice in notices) {
        noticeInstances.add(NoticeModel.fromJson(notice));
      }

      var res = NoticesResponse(
        notices: noticeInstances,
        lastCursorId: jsonData['lastCursorId'],
        hasNext: jsonData['hasNext'],
      );

      return res;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load notices');
    }
  }

  static Future<NoticeModel> getNoticeDetailById(int id) async {
    final url = Uri.parse('$baseUrl/announcement/$id');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonData = jsonDecode(decodedBody);
      var detail = NoticeModel.fromJson(jsonData);
      return detail;
    }
    print('Request failed with status: ${response.statusCode}.');
    throw Exception('Failed to load noticeDetail');
  }
}
