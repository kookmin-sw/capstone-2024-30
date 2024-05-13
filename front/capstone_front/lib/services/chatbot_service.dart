import 'dart:convert';

import 'package:capstone_front/models/api_fail_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<String> getChatbotAnswer(String question) async {
  final String baseUrl = dotenv.get('BASE_URL');
  final url = Uri.parse('$baseUrl/chatbot');

  FlutterSecureStorage storage = const FlutterSecureStorage();
  final accessToken = await storage.read(key: "accessToken");
  String language = "KO";

  final tmpLanguage = await storage.read(key: "language");
  if (tmpLanguage != null) {
    language = tmpLanguage;
  }

  Map data = {
    "query": question,
    "target_lang": language,
  };
  var body = json.encode(data);

  final response = await http.post(
    url,
    headers: {
      'Content-Type': "application/json",
      'Authorization': 'Bearer $accessToken',
    },
    body: body,
  );

  final Map<String, dynamic> jsonMap =
      jsonDecode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    print("success");
    return jsonMap['response']['answer'];
  } else {
    // var apiFailResponse = ApiFailResponse.fromJson(jsonMap);
    // print(apiFailResponse.message);
    print(response.body);
    print('Request failed with status: ${response.statusCode}.');
    throw Exception('Failed to load chatbot answer');
  }
}
