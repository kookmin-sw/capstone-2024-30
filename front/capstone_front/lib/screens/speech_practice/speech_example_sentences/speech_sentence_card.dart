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
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 5, bottom: 10),
      child: InkWell(
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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 15.0 + _verticalPadding, horizontal: 15),
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
                const SizedBox(
                  height: 4,
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
                child: Text(tr("speech.cancel")),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  openAppSettings();
                },
                child: Text(tr("speech.setting")),
              ),
            ),
          ],
        );
      }),
    );
  }
}
