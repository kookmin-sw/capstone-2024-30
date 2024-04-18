import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class AuthService {
  static String baseUrl = dotenv.get('BASE_URL');
  static final List<int> key = utf8.encode('i dont know the key');

  static Future<Map<String, dynamic>> signUp(
      Map<String, dynamic> userInfo) async {
    var json = jsonEncode(userInfo);
    var bytes = utf8.encode(json);

    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);

    final url = Uri.parse('$baseUrl/user/signup');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'HMAC': digest.toString(),
      },
      body: jsonEncode(userInfo),
    );

    if (response.statusCode == 201) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> res = jsonDecode(decodedBody);

      return res;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load notices');
    }
  }

  static Future<Map<String, dynamic>> signIn(Map<String, dynamic> info) async {
    var json = jsonEncode(info);
    var bytes = utf8.encode(json);

    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);
    final url = Uri.parse('$baseUrl/user/signin');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'HMAC': digest.toString(),
      },
      body: jsonEncode(info),
    );

    if (response.statusCode == 200) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> res = jsonDecode(decodedBody);

      return res;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load notices');
    }
  }

  static Future<Map<String, dynamic>> reissue(
      Map<String, dynamic> refreshTokenObj) async {
    final url = Uri.parse('$baseUrl/auth/reissue');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(refreshTokenObj),
    );

    if (response.statusCode == 200) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> res = jsonDecode(decodedBody);

      return res;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load notices');
    }
  }
}
