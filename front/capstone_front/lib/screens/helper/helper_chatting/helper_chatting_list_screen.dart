import 'dart:convert';

import 'package:capstone_front/models/chat_model.dart';
import 'package:capstone_front/models/chat_room_model.dart';
import 'package:capstone_front/screens/helper/helper_chatting/helper_chatting_card.dart';
import 'package:capstone_front/screens/helper/helper_chatting/helper_chatting_json.dart';
import 'package:capstone_front/services/chat_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperChattingListScreen extends StatefulWidget {
  const HelperChattingListScreen({super.key});

  @override
  State<HelperChattingListScreen> createState() =>
      _HelperChattingListScreenState();
}

class _HelperChattingListScreenState extends State<HelperChattingListScreen> {
  late List<ChatRoomModel> chatRoomList = [];
  late List<ChatRoomModel> myChatRooms = [];
  late List<Map<String, dynamic>> currentChatRoomInfos = [];
  late List<ChatModelForChatList> currentNewChatsInfos = [];
  bool isActive = true;

  Future<void> loadChatRooms() async {
    currentChatRoomInfos.clear();
    chatRoomList = await ChatService.loadChatRooms();
    for (var chatRoom in chatRoomList) {
      currentChatRoomInfos.add({
        "id": chatRoom.chatRoomId,
        "message_id": chatRoom.lastMessagePreviewId,
      });
    }
    setState(() {});
  }

  // 채팅방 데이터 저장
  Future<void> saveChatRoomData(List<ChatRoomModel> chatRooms) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> chatRoomData =
        chatRooms.map((chatRoom) => json.encode(chatRoom.toJson())).toList();
    await prefs.setStringList('chatRoomData', chatRoomData);
  }

  Future<void> startPolling(Map<String, dynamic> roomInfo) async {
    try {
      while (isActive) {
        // loadChatRooms();
        try {
          var currentNewChatsInfos =
              await ChatService.pollingChatList(roomInfo);
          print('roominfo');
          print(roomInfo);
          for (var newChatInfo in currentNewChatsInfos) {
            var flag = true; // 새로운 채팅방인지 아닌지 확인
            for (var chatRoom in chatRoomList) {
              if (newChatInfo.chatRoomId == chatRoom.chatRoomId) {
                flag = false;
                chatRoom.lastMessagePreviewId = newChatInfo.id;
                chatRoom.chatRoomMessage = newChatInfo.content;
                chatRoom.chatRoomDate = newChatInfo.timestamp;
                break;
              }
            }

            if (flag) {
              // 새로운 채팅방일 때
              chatRoomList.add(ChatRoomModel(
                chatRoomId: newChatInfo.chatRoomId,
                userId: newChatInfo.userId,
                userName: newChatInfo.userId,
                lastMessageId: 0,
                lastMessagePreviewId: newChatInfo.id,
                chatRoomMessage: newChatInfo.content,
                chatRoomDate: newChatInfo.timestamp,
              ));
            }
          }

          setState(() {
            saveChatRoomData(chatRoomList);
          });
          setState(() {});

          await Future.delayed(const Duration(seconds: 3));
        } catch (e) {
          print('Error while polling Chat List: $e');
          await Future.delayed(const Duration(seconds: 3));
        }
      }
    } catch (e) {
      print('Unexpected error in polling loop: $e');
    }
  }

  @override
  void initState() {
    loadChatRooms().then((_) {
      startPolling({
        "list": currentChatRoomInfos,
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    isActive = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatRoomList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: HelperChattingCard(
              chatRoomModel: chatRoomList[index],
              chatRoomListUpdate: loadChatRooms,
            ),
          );
        },
      ),
    );
  }
}
