import 'package:capstone_front/screens/speeking_practice/utils/simple_recorder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PronunciationPracticeScreen extends StatefulWidget {
  const PronunciationPracticeScreen({super.key});

  @override
  State<PronunciationPracticeScreen> createState() =>
      _PronunciationPracticeStateScreen();
}

class _PronunciationPracticeStateScreen
    extends State<PronunciationPracticeScreen> {
  @override
  bool showPlayer = false;
  String? audioPath;

  @override
  Widget build(BuildContext context) {
    // 이전 페이지에서 문장을 받아옴
    final String sentence = GoRouterState.of(context).extra! as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('pronunciationPracticeScreen.pronunciation_practice'),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              sentence,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SimpleRecorder(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }
}
