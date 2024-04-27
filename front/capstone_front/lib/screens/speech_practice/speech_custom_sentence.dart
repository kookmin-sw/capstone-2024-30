import 'package:capstone_front/utils/basic_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xffd2d7dd),
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 2,
                  maxLines: 2,
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
              const Spacer(),
              BasicButton(
                  text: tr('speech.speech_practice'),
                  onPressed: () {
                    context.push('/speech/practice',
                        extra: [_textController.text, '']);
                  }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
