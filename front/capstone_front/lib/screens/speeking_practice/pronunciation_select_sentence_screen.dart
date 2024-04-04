import 'package:capstone_front/screens/speeking_practice/pronunciation_sentence_card.dart';
import 'package:capstone_front/screens/speeking_practice/utils/example_sentences.dart';
import 'package:capstone_front/screens/speeking_practice/utils/simple_recorder.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          tr('pronunciationPracticeScreen.pronunciation_practice'),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: PronunciationSentenceCard(
                index: index,
                canTap: true,
                verticalPadding: 0,
              ),
            );
          },
          itemCount: sentences.length,
        ),
      ),
    );
  }

  // // 예문 카드
  // InkWell exampleSentenceCard(BuildContext context, int index) {
  //   return InkWell(
  //     onTap: () async {
  //       var status = await Permission.microphone.request();
  //       if (status != PermissionStatus.granted) {
  //         permssionNotice(context);
  //       } else {
  //         // pageController.animateToPage(
  //         //   1,
  //         //   duration: const Duration(milliseconds: 500),
  //         //   curve: Curves.easeInOut,
  //         // );
  //       }
  //     },
  //     child: Ink(
  //       width: double.infinity,
  //       height: 80,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(16),
  //         border: Border.all(color: const Color(0xffd2d7dd), width: 2),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               sentences[index][0],
  //               style: const TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //             Text(
  //               sentences[index][1],
  //               style: Theme.of(context).textTheme.bodySmall,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // // 녹음 권한 거부 시 설정
  // Future<dynamic> permssionNotice(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: ((context) {
  //       return AlertDialog(
  //         content:
  //             Text(tr("pronunciationPracticeScreen.permission_allow_notice")),
  //         actions: [
  //           Container(
  //             child: ElevatedButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text("취소"),
  //             ),
  //           ),
  //           Container(
  //             child: ElevatedButton(
  //               onPressed: () {
  //                 openAppSettings();
  //               },
  //               child: const Text("설정"),
  //             ),
  //           ),
  //         ],
  //       );
  //     }),
  //   );
  // }
}
