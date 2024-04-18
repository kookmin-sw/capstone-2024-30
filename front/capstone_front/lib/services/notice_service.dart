import 'dart:convert';

import 'package:capstone_front/models/notice_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NoticeService {
  static String baseUrl = dotenv.get('BASE_URL');

  static Future<List<NoticeModel>> getNotices() async {
    List<NoticeModel> noticeInstances = [];
    final url = Uri.parse('$baseUrl/announcement/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final List<dynamic> notices = jsonDecode(decodedBody);

      for (var notice in notices) {
        noticeInstances.add(NoticeModel.fromJson(notice));
      }
      return noticeInstances;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load notices');
    }
  }
}
