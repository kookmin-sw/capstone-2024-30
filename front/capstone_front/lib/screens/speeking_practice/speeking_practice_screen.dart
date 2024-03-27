import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SpeekingPracticeScreen extends StatefulWidget {
  const SpeekingPracticeScreen({super.key});

  @override
  State<SpeekingPracticeScreen> createState() => _SpeekingPracticeScreenState();
}

class _SpeekingPracticeScreenState extends State<SpeekingPracticeScreen> {
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
          tr('speekingPracticeScreen.pronunciation_practice'),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 50,
              child: Center(
                child: Text(sentences[index]),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Theme.of(context).colorScheme.onSurface,
            );
          },
          itemCount: sentences.length,
        ),
      ),
    );
  }
}
