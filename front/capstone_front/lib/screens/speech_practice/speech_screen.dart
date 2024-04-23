import 'package:capstone_front/screens/speech_practice/speech_custom_sentence.dart';
import 'package:capstone_front/screens/speech_practice/speech_select_sentence_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  int _selectedPageIndex = 0;
  final _speechScreenList = [
    const SpeechSentenceScreen(),
    const SpeechCustomSentenceScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPageIndex = 0;
                });
              },
              child: Text(
                tr('speech.example_sentence'),
                style: TextStyle(
                  color: _selectedPageIndex == 0 ? Colors.black : Colors.grey,
                ),
              ),
            ),
            const Text('  '),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPageIndex = 1;
                });
              },
              child: Text(
                tr('speech.custom_sentence'),
                style: TextStyle(
                  color: _selectedPageIndex == 1 ? Colors.black : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: _speechScreenList.elementAt(_selectedPageIndex),
      ),
    );
  }
}
