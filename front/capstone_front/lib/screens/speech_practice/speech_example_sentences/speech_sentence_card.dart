import 'package:capstone_front/screens/speech_practice/utils/example_sentences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class SpeechSentenceCard extends StatefulWidget {
  final int index;
  final bool canTap;
  final double verticalPadding;
  const SpeechSentenceCard({
    super.key,
    required this.index,
    required this.canTap,
    required this.verticalPadding,
  });

  @override
  State<SpeechSentenceCard> createState() => _SpeechSentenceCardState();
}

class _SpeechSentenceCardState extends State<SpeechSentenceCard> {
  int get _index => widget.index;
  bool get _canTap => widget.canTap;
  double get _verticalPadding => widget.verticalPadding;
  final List<List<String>> _sentences = sentences;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _canTap
          ? () async {
              var status = await Permission.microphone.request();
              if (status != PermissionStatus.granted) {
                permssionNotice(context);
              } else {
                context.push('/speech/practice',
                    extra: [sentences[_index][0], sentences[_index][1]]);
              }
            }
          : null,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xffd2d7dd),
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 10.0 + _verticalPadding, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sentences[_index][0],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                sentences[_index][1],
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
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
          content:
              Text(tr("pronunciationPracticeScreen.permission_allow_notice")),
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
