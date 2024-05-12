import 'dart:convert';

import 'package:capstone_front/models/api_fail_response.dart';
import 'package:capstone_front/models/cafeteria_menu_model_ko.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<CafeteriaMenuModel> getCafeteriaMenu(String date) async {
  final String baseUrl = dotenv.get('BASE_URL');

  FlutterSecureStorage storage = const FlutterSecureStorage();
  final language = await storage.read(key: "language");

  final url = Uri.parse('$baseUrl/menu/daily?date=$date&language=$language');
  print(url);
  final response = await http.get(url);

  final Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    // print(json['response']);
    return CafeteriaMenuModel.fromJson(json['response'], date);
  } else {
    var apiFailResponse = ApiFailResponse.fromJson(json);
    print('Request failed with status: ${response.statusCode}.');
    print(apiFailResponse.message);
    throw Exception('Failed to load cafeteria menu');
  }
}
