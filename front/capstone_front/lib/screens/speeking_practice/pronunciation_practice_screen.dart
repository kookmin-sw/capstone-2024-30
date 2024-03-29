import 'package:capstone_front/screens/speeking_practice/pronunciation_sentence_card.dart';
import 'package:capstone_front/screens/speeking_practice/utils/simple_recorder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class PronunciationPracticeScreen extends StatefulWidget {
  const PronunciationPracticeScreen({super.key});

  @override
  State<PronunciationPracticeScreen> createState() =>
      _PronunciationPracticeScreenState();
}

class _PronunciationPracticeScreenState
    extends State<PronunciationPracticeScreen> {
  double translateX = 0.0;
  @override
  Widget build(BuildContext context) {
    final int index = GoRouterState.of(context).extra! as int;
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
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: PronunciationSentenceCard(
                index: index,
                canTap: false,
                verticalPadding: 20,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 700,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: Colors.black),
                      // border: const Border(top: BorderSide(color: Colors.black)),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          dividerWithText(" 정확도 총점 "),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: circleScore(90, "대단해요!"),
                          ),
                          const SizedBox(height: 30),
                          dividerWithText(" 분석 결과 상세 "),
                        ],
                      ),
                    )),
              ),
            ),
            const SimpleRecorder(),
          ],
        ),
      ),
    );
  }

  Container dividerWithText(String text) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xff929292),
          ),
        ),
      ),
      child: Transform.translate(
        offset: const Offset(0, -14),
        child: Align(
            child: Container(
          color: Colors.white,
          child: Text(
            text,
            style: const TextStyle(
                color: Color(0xff929292), fontWeight: FontWeight.w600),
          ),
        )),
      ),
    );
  }

  Stack circleScore(int value, String label) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: CircularProgressIndicator(
            value: value / 100.0, // 현재 진행률
            strokeWidth: 10, // 선의 두께
            backgroundColor: Colors.grey.shade300, // 배경색
            color: Theme.of(context).colorScheme.primary, // 진행 색상
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$value', // 현재 값
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              label, // '대단해요!' 라벨
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
