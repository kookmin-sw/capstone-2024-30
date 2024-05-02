import 'package:capstone_front/models/chat_init_model.dart';
import 'package:capstone_front/models/chat_room_model.dart';
import 'package:capstone_front/screens/helper/helper_board/helper_writing_json.dart';
import 'package:capstone_front/screens/helper/helper_chatting/helper_chatting_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class HelperChattingCard extends StatefulWidget {
  final ChatRoomModel chatRoomModel;

  const HelperChattingCard({
    super.key,
    required this.chatRoomModel,
  });

  @override
  State<HelperChattingCard> createState() => _HelperChattingCardState();
}

class _HelperChattingCardState extends State<HelperChattingCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var chatInitModel = ChatInitModel.fromJson({
          "author": widget.chatRoomModel.userName,
          "uuid": widget.chatRoomModel.userId,
        });
        context.push("/chatroom", extra: chatInitModel);
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
                  width: MediaQuery.of(context).size.width - 110,
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
      ),
    );
  }
}
