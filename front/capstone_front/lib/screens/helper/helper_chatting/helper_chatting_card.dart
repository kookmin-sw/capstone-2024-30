import 'dart:convert';

import 'package:capstone_front/models/chat_init_model.dart';
import 'package:capstone_front/models/chat_model.dart';
import 'package:capstone_front/models/chat_room_model.dart';
import 'package:capstone_front/screens/helper/helper_board/helper_writing_json.dart';
import 'package:capstone_front/screens/helper/helper_chatting/helper_chatting_json.dart';
import 'package:capstone_front/screens/helper/helper_chatting/helper_chatting_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperChattingCard extends StatefulWidget {
  final ChatRoomModel chatRoomModel;
  final Function() chatRoomListUpdate;

  const HelperChattingCard({
    super.key,
    required this.chatRoomModel,
    required this.chatRoomListUpdate,
  });

  @override
  State<HelperChattingCard> createState() => _HelperChattingCardState();
}

class _HelperChattingCardState extends State<HelperChattingCard> {
  int lastMessageId = 0;

  // 채팅 데이터 불러오기
  Future<List<ChatModel>> loadChatData(String partner) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> chatData = prefs.getStringList(partner) ?? [];

    return chatData
        .map((chat) => ChatModel.fromJson(json.decode(chat)))
        .toList();
  }

  Future<void> initInitialState() async {
    var chatHistory = await loadChatData(widget.chatRoomModel.userId);
    if (chatHistory.isNotEmpty) {
      setState(() {
        lastMessageId = chatHistory.last.id;
      });
    }
  }

  @override
  void initState() {
    initInitialState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var chatInitModel = ChatInitModel.fromJson({
          "author": widget.chatRoomModel.userName,
          "uuid": widget.chatRoomModel.userId,
        });
        // context.go("/chatroom", extra: chatInitModel);
        var result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HelperChattingRoom(chatInitModel)));
        await widget.chatRoomListUpdate();
        await initInitialState();
        if (result == 'g') {
          setState(() {});
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
            // border: Border(
            //   bottom: BorderSide(
            //     color: Color(0xffd2d7dd),
            //   ),
            // ),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset('assets/images/carrot_profile.png'),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.chatRoomModel.userName,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.chatRoomModel.chatRoomDate,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff868e96),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: Text(
                        widget.chatRoomModel.chatRoomMessage,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff868e96),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                lastMessageId != widget.chatRoomModel.lastMessagePreviewId
                    ? const Text(
                        "N",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: Color(0xffff0000),
                        ),
                      )
                    : const Text(""),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
