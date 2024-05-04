import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String> getChatbotAnswer(String question) async {
  // final String baseUrl = dotenv.get('BASE_URL');
  const String baseUrl = "https://jsonplaceholder.typicode.com/todos/1";
  final url = Uri.parse(baseUrl);
  final response = await http.get(url);

  final Map<String, dynamic> jsonMap =
      jsonDecode(utf8.decode(response.bodyBytes));

  return jsonMap['title'];
}
