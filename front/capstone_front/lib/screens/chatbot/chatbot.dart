import 'package:capstone_front/services/chatbot_service.dart';
import 'package:capstone_front/utils/bubble_painter_right.dart';
import 'package:capstone_front/utils/bubble_painter_left.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final List<List<String>> _messages = [];
  final int _maxLines = 1;
  bool _isLoading = true;

  void _sendMessage() async {
    if (_textController.text.isNotEmpty) {
      String question = _textController.text;
      setState(() {
        // Todo: _textController.text를 서버로 보내고 답변 받아오기
        _messages.add([question, 'user']);
        _textController.clear();
        _messages.add([tr("chatbotScreen.loading"), 'chatbot']);
        _isLoading = false;
      });

      String chatbotAnswer = await getChatbotAnswer(question);

      setState(() {
        _isLoading = true;
        _messages[_messages.length - 1][0] = chatbotAnswer;

        // 텍스트 입력 시 방금 입력된 텍스트가 보일 수 있도록 이동
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          tr('chatbotScreen.chatbot'),
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
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            left: 20,
                            right: 20,
                            // bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: _messages[_messages.length - 1 - index][1] ==
                                  "user"
                              ? Container(
                                  alignment: Alignment.centerRight,
                                  child: CustomPaint(
                                    painter: BubblePainterRight(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        _messages[_messages.length - 1 - index]
                                            [0],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.centerLeft,
                                  child: CustomPaint(
                                    painter: BubblePainterLeft(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        _messages[_messages.length - 1 - index]
                                            [0],
                                      ),
                                    ),
                                  ),
                                ));
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
                        decoration: InputDecoration.collapsed(
                          hintText: tr('chatbotScreen.textfield_hint'),
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
