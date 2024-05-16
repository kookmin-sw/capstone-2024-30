import 'package:capstone_front/utils/basic_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class SpeechCustomSentenceScreen extends StatefulWidget {
  const SpeechCustomSentenceScreen({super.key});

  @override
  State<SpeechCustomSentenceScreen> createState() =>
      _SpeechCustomSentenceScreenState();
}

class _SpeechCustomSentenceScreenState
    extends State<SpeechCustomSentenceScreen> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 2,
                  maxLines: 5,
                  maxLength: 40,
                  controller: _textController,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration.collapsed(
                    hintText: tr('speech.hint_custom_example'),
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: BasicButton(
                  text: tr('speech.speech_practice'),
                  onPressed: () async {
                    var status = await Permission.microphone.request();
                    if (status != PermissionStatus.granted) {
                      permssionNotice(context);
                    } else {
                      context.push('/speech/practice',
                          extra: [_textController.text, '']);
                    }
                  }),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  // 녹음 권한 거부 시 설정
  Future<dynamic> permssionNotice(BuildContext context) {
    return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          content: Text(tr("speech.permission_allow_notice")),
          actions: [
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("취소"),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  openAppSettings();
                },
                child: const Text("설정"),
              ),
            ),
          ],
        );
      }),
    );
  }
}
