import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class PronunciationSentenceScreen extends StatefulWidget {
  const PronunciationSentenceScreen({super.key});

  @override
  State<PronunciationSentenceScreen> createState() =>
      _PronunciationSentenceScreenState();
}

class _PronunciationSentenceScreenState
    extends State<PronunciationSentenceScreen> {
  final List<String> sentences = <String>[
    '동해물과 백두산이',
    '마르고 닳도록',
    '하느님이 보우하사',
    '우리나라만세',
    '무궁화 삼천리',
    '화려강산',
    '대한사람 대한으로',
    '길이 보전하세',
    '남산위에 저 소나무',
    '철갑을 두른 듯',
    '바람서리 불변함은',
    '우리 기상일세',
    '무궁화 삼천리',
    '화려강산',
    '대한사람 대한으로',
    '길이 보전하세',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('pronunciationPracticeScreen.pronunciation_practice'),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () async {
                var status = await Permission.microphone.request();
                if (status != PermissionStatus.granted) {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          content: Text(tr(
                              "pronunciationPracticeScreen.permission_allow_notice")),
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
                      }));
                } else {
                  context.push('/pronunciation/practice',
                      extra: sentences[index]);
                }
              },
              child: Ink(
                height: 50,
                decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xFFD6D6D6)))),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    sentences[index],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: sentences.length,
        ),
      ),
    );
  }
}
