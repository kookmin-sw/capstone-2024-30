import 'package:capstone_front/screens/speech_practice/utils/example_sentences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class SpeechPracticeCard extends StatefulWidget {
  final String sentence1;
  final String sentence2;
  final double verticalPadding;
  const SpeechPracticeCard({
    super.key,
    required this.sentence1,
    required this.sentence2,
    required this.verticalPadding,
  });

  @override
  State<SpeechPracticeCard> createState() => _SpeechPracitceCardState();
}

class _SpeechPracitceCardState extends State<SpeechPracticeCard> {
  double get _verticalPadding => widget.verticalPadding;
  final List<List<String>> _sentences = sentences;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            vertical: 10.0 + _verticalPadding, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.sentence1,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              widget.sentence2,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
