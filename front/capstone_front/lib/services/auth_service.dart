import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class AuthService {
  static String baseUrl = dotenv.get('BASE_URL');
  static final List<int> key = base64Decode(dotenv.get('HMAC_SECRET'));

  static Future<Map<String, dynamic>> signUp(
      Map<String, dynamic> userInfo) async {
    var hmacSha256 = Hmac(sha256, key);
    final url = Uri.parse('$baseUrl/user/signup');

    var dummy = {
      "uuid": "string",
      "email": "aㅁqazzaamclub4@kookmin.ac.kr",
      "name": "string",
      "country": "string",
      "phoneNumber": "010-8276-8291",
      "major": "string"
    };

    // var json = jsonEncode(dummy);
    var json = jsonEncode(userInfo);
    var bytes = utf8.encode(json);
    var digest = hmacSha256.convert(bytes);
    var base64EncodedDigest = base64Encode(digest.bytes);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'HMAC': base64EncodedDigest,
      },
      body: json,
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> res = jsonDecode(decodedBody);

    if (response.statusCode != 201) {
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with status: ${response.body}');
    }

    return res;
  }

  static Future<Map<String, dynamic>> signIn(Map<String, dynamic> info) async {
    var hmacSha256 = Hmac(sha256, key);
    final url = Uri.parse('$baseUrl/user/signin');

    var json = jsonEncode(info);
    var bytes = utf8.encode(json);
    var digest = hmacSha256.convert(bytes);
    var base64EncodedDigest = base64Encode(digest.bytes);

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'HMAC': base64EncodedDigest,
      },
      body: json,
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> res = jsonDecode(decodedBody);

    if (response.statusCode != 200) {
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with status: ${response.body}');
    }

    return res;
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

    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> res = jsonDecode(decodedBody);

    if (response.statusCode != 200) {
      print('Request failed with status: ${response.statusCode}.');
    }

    return res;
  }
}
