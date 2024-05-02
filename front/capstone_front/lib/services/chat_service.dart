import 'dart:convert';

import 'package:capstone_front/models/api_fail_response.dart';
import 'package:capstone_front/models/api_success_response.dart';
import 'package:capstone_front/models/chat_model.dart';
import 'package:capstone_front/models/chat_room_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatService {
  static String baseUrl = dotenv.get('BASE_URL');

  static Future<int> connectChat(String userId) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");

    final url = Uri.parse('$baseUrl/chat/connect/$userId');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> jsonMap = jsonDecode(decodedBody);
    if (response.statusCode == 201 || response.statusCode == 200) {
      // 201은 새로 생성된 경우, 200은 이미 존재했으나, 본인이 채팅리스트 화면에 가지 않아, 최신화가 되지 않은 상태라 모르는 경우
      var apiSuccessResponse = ApiSuccessResponse.fromJson(jsonMap);

      return apiSuccessResponse.response['chat_room_id'];
    } else {
      var apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print(response.statusCode);
      print(apiFailResponse.message);
      throw Exception("fail to connect chatroom");
    }
  }

  static Future<List<ChatModel>?> loadNewChats(
      int chatRoomId, int lastMessageId) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");

    final url = Uri.parse('$baseUrl/chat/join/$chatRoomId/$lastMessageId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> jsonMap = jsonDecode(decodedBody);
    List<ChatModel> chatInstances = [];

    if (response.statusCode == 200) {
      print('load new chats');
      var apiSuccessResponse = ApiSuccessResponse.fromJson(jsonMap);
      final List<dynamic> chats = apiSuccessResponse.response['messages'];

      for (var chat in chats) {
        chatInstances.add(ChatModel.fromJson(chat));
      }

      return chatInstances;
    } else if (response.statusCode == 400) {
      print('not load new chats');
      // 새로 로드할 채팅이 없을 때
      return null;
    } else {
      var apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print(response.statusCode);
      print(apiFailResponse.message);
      throw Exception("fail to load newChats");
    }
  }

  static Future<List<ChatModel>> pollingChat(
      int chatRoomId, int lastMessageId) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");

    final url = Uri.parse('$baseUrl/chat/poll/$chatRoomId/$lastMessageId');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> jsonMap = jsonDecode(decodedBody);
    List<ChatModel> chatInstances = [];

    if (response.statusCode == 200) {
      var apiSuccessResponse = ApiSuccessResponse.fromJson(jsonMap);
      final List<dynamic> chats = apiSuccessResponse.response['messages'];

      for (var chat in chats) {
        chatInstances.add(ChatModel.fromJson(chat));
      }

      return chatInstances;
    } else {
      print('여기');
      var apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print(response.statusCode);
      print(apiFailResponse.message);
      throw Exception("fail to poilling chats");
    }
  }

  static Future<ChatModel> sendChat(int chatRoomId, String content) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");

    final url = Uri.parse('$baseUrl/chat/$chatRoomId');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        "content": content,
      }),
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> jsonMap = jsonDecode(decodedBody);
    if (response.statusCode == 201) {
      var apiSuccessResponse = ApiSuccessResponse.fromJson(jsonMap);
      var chatModel = ChatModel.fromJson(apiSuccessResponse.response);

      return chatModel;
    } else {
      var apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print(response.statusCode);
      print(apiFailResponse.message);
      throw Exception("fail to send chats");
    }
  }

  static Future<List<ChatRoomModel>> loadChatRooms() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");

    final url = Uri.parse('$baseUrl/chat/');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    List<ChatRoomModel> chatRoomInstances = [];

    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> jsonMap = jsonDecode(decodedBody);
    if (response.statusCode == 200) {
      var apiSuccessResponse = ApiSuccessResponse.fromJson(jsonMap);
      final List<dynamic> chatRooms = apiSuccessResponse.response['rooms'];

      for (var chatRoom in chatRooms) {
        chatRoomInstances.add(ChatRoomModel.fromJson(chatRoom));
      }

      return chatRoomInstances;
    } else {
      var apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print(response.statusCode);
      print(apiFailResponse.message);
      throw Exception("fail to load chatRooms");
    }
  }

  static Future<List<ChatModelForChatList>> pollingChatList(
      Map<String, dynamic> myChatRooms) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");

    final url = Uri.parse('$baseUrl/chat/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: {
        jsonEncode(myChatRooms),
      },
    );

    List<ChatModelForChatList> chatForChatListInstances = [];

    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> jsonMap = jsonDecode(decodedBody);
    if (response.statusCode == 200) {
      var apiSuccessResponse = ApiSuccessResponse.fromJson(jsonMap);
      final List<dynamic> chatModelForChatRooms =
          apiSuccessResponse.response['messages'];

      for (var chatModel in chatModelForChatRooms) {
        chatForChatListInstances.add(ChatModelForChatList.fromJson(chatModel));
      }

      return chatForChatListInstances;
    } else {
      var apiFailResponse = ApiFailResponse.fromJson(jsonMap);
      print(response.statusCode);
      print(apiFailResponse.message);
      throw Exception("fail to polling chatList");
    }
  }
}
