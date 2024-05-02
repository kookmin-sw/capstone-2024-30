import 'dart:convert';
import 'dart:io';

import 'package:capstone_front/models/chat_init_model.dart';
import 'package:capstone_front/models/chat_model.dart';
import 'package:capstone_front/models/chat_room_model.dart';
import 'package:capstone_front/services/chat_service.dart';
import 'package:capstone_front/utils/bubble_painter1.dart';
import 'package:capstone_front/utils/bubble_painter2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperChattingRoom extends StatefulWidget {
  final ChatInitModel chatInitModel;

  const HelperChattingRoom(this.chatInitModel, {super.key});

  @override
  State<HelperChattingRoom> createState() => _HelperChattingRoomState();
}

class _HelperChattingRoomState extends State<HelperChattingRoom> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  late String userId = widget.chatInitModel.uuid;
  late String userName = widget.chatInitModel.author;
  late int chatRoomId;
  late int lastMessageId = 0;
  late String lastMessage = "";
  late String chatRoomDate = "";
  late List<ChatModel> messages = [];
  bool isActive = true;
  late ChatRoomModel currentChatRoom;
  late List<ChatRoomModel> chatRoomList;

  void _sendMessage() async {
    if (_textController.text.isNotEmpty) {
      var content = _textController.text;
      var newChat = await ChatService.sendChat(chatRoomId, content);

      setState(() {
        messages.insert(messages.length, newChat);
        _textController.clear();

        // 텍스트 입력 시 방금 입력된 텍스트가 보일 수 있도록 이동
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
        );
        saveChatData(messages, userId);
      });
    }
  }

  // 채팅 데이터 저장
  Future<void> saveChatData(List<ChatModel> chats, String partner) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> chatData =
        chats.map((chat) => json.encode(chat.toJson())).toList();

    await prefs.setStringList(partner, chatData);
  }

  // 채팅 데이터 불러오기
  Future<List<ChatModel>> loadChatData(String partner) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> chatData = prefs.getStringList(partner) ?? [];

    return chatData
        .map((chat) => ChatModel.fromJson(json.decode(chat)))
        .toList();
  }

  // 채팅방 데이터 저장
  Future<void> saveChatRoomData(List<ChatRoomModel> chatRooms) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> chatRoomData =
        chatRooms.map((chatRoom) => json.encode(chatRoom.toJson())).toList();
    await prefs.setStringList('chatRoomData', chatRoomData);
  }

// 채팅방 데이터 불러오기
  Future<List<ChatRoomModel>> loadChatRoomData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> chatRoomData = prefs.getStringList('chatRoomData') ?? [];
    return chatRoomData
        .map((chatRoom) => ChatRoomModel.fromJson(json.decode(chatRoom)))
        .toList();
  }

  // 초기 채팅방을 설정함
  Future<void> initializeChat() async {
    chatRoomList = await loadChatRoomData();

    var flag = false;
    for (var chatRoom in chatRoomList) {
      // uuid로 이 사람과의 채팅이 처음인지 아닌지 판단
      print(chatRoom.userId);
      print(1);
      print(userId);
      if (chatRoom.userId == userId) {
        flag = true;
        var chatHistory = await loadChatData(userId);
        setState(() {
          chatRoomId = chatRoom.chatRoomId;
          lastMessageId = chatRoom.lastMessageId;
          lastMessage = chatRoom.chatRoomMessage;
          chatRoomDate = chatRoom.chatRoomDate;
          messages = chatHistory;
          currentChatRoom = chatRoom;
        });
        break;
      }
    }

    if (flag) {
      var newChats = await ChatService.loadNewChats(chatRoomId, lastMessageId);
      if (newChats != null) {
        messages.addAll(newChats);
        lastMessageId = newChats.last.id;
        currentChatRoom.lastMessageId = newChats.last.id;
        saveChatRoomData(chatRoomList);
        setState(() {});
      }
    } else {
      var newChatRoomId = await ChatService.connectChat(userId);
      var newChatRoom = ChatRoomModel(
        chatRoomId: newChatRoomId,
        userId: userId,
        userName: userName,
        lastMessageId: lastMessageId,
        chatRoomMessage: lastMessage,
        chatRoomDate: chatRoomDate,
      );

      setState(() {
        chatRoomId = newChatRoomId;
        lastMessageId = 0;
        lastMessage = "";
        chatRoomDate = "";
        messages = [];
        chatRoomList.add(newChatRoom);
        currentChatRoom = newChatRoom;
        saveChatRoomData(chatRoomList);
      });
    }
  }

  Future<void> startPolling(int chatRoomId, int lastMessageId) async {
    print('chatRoomId');
    print(chatRoomId);
    try {
      while (isActive) {
        print(1);
        try {
          var newMessages =
              await ChatService.pollingChat(chatRoomId, lastMessageId);
          if (newMessages.isNotEmpty) {
            print("GOT MESSAGE");
            setState(() {
              messages.addAll(newMessages);
              lastMessageId = messages.last.id;
              currentChatRoom.lastMessageId = messages.last.id;
              saveChatRoomData(chatRoomList);
              saveChatData(messages, userId);
            });
          }

          await Future.delayed(const Duration(seconds: 3));
        } catch (e) {
          print('Error while polling: $e');
          await Future.delayed(const Duration(seconds: 3));
        }
      }
    } catch (e) {
      print('Unexpected error in polling loop: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    initializeChat().then((_) {
      startPolling(chatRoomId, lastMessageId);
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          "최지훈",
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          left: 20,
                          right: 20,
                          // bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Container(
                          alignment:
                              messages[messages.length - 1 - index].userId ==
                                      userId
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                          child: CustomPaint(
                            painter:
                                messages[messages.length - 1 - index].userId ==
                                        userId
                                    ? BubblePainter2()
                                    : BubblePainter(),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                messages[messages.length - 1 - index].content,
                                style: TextStyle(
                                  color: messages[messages.length - 1 - index]
                                              .userId ==
                                          userId
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          // const Divider(
          //   height: 0.0,
          //   color: Colors.white,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFDFE7EE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 10, bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 3,
                        controller: _textController,
                        textInputAction: TextInputAction.newline,
                        decoration: const InputDecoration.collapsed(
                          hintText: "채팅을 입력하세요",
                        ),
                        style: Theme.of(context).textTheme.bodySmall,
                        // onTap: () {
                        //   if (_scrollController.position ==
                        //       _scrollController.position.maxScrollExtent) {
                        //     _scrollController.jumpTo(
                        //         _scrollController.position.maxScrollExtent);
                        //   }
                        // },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
