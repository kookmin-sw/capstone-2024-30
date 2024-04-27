import 'package:capstone_front/screens/speech_practice/speech_sentence_card.dart';
import 'package:capstone_front/screens/speech_practice/utils/example_sentences.dart';
import 'package:flutter/material.dart';

class SpeechSentenceScreen extends StatefulWidget {
  const SpeechSentenceScreen({super.key});

  @override
  State<SpeechSentenceScreen> createState() => _SpeechSentenceScreenState();
}

class _SpeechSentenceScreenState extends State<SpeechSentenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SpeechSentenceCard(
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
}
