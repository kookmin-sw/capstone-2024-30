import 'dart:io';

import 'package:capstone_front/models/speech_model.dart';
import 'package:capstone_front/screens/speech_practice/speech_custom_sentence/speech_practice_card.dart';
import 'package:capstone_front/screens/speech_practice/utils/example_sentences.dart';
import 'package:capstone_front/screens/speech_practice/utils/recorder_screen.dart';
import 'package:capstone_front/screens/speech_practice/utils/simple_recorder.dart';
import 'package:capstone_front/services/speech_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class SpeechPracticeScreen extends StatefulWidget {
  const SpeechPracticeScreen({super.key});

  @override
  State<SpeechPracticeScreen> createState() => _SpeechScreenState();
}

late String filePath;

class _SpeechScreenState extends State<SpeechPracticeScreen> {
  late SpeechModel speechModel;
  double translateX = 0.0;
  bool getSpeechModel = false;
  List<int> numWordErrors = [0, 0, 0];
  List<Container> wordContainerList = [];

  @override
  Widget build(BuildContext context) {
    final List<String> sentenceList =
        GoRouterState.of(context).extra! as List<String>;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Text(
          tr('speech.speech_practice'),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SpeechPracticeCard(
                sentence1: sentenceList[0],
                sentence2: sentenceList[1],
                verticalPadding: 20,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Colors.black),
                    // border: const Border(top: BorderSide(color: Colors.black)),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: getSpeechModel
                      ? FutureBuilder(
                          future: getSpeechResult(filePath, sentenceList[0]),
                          builder: (
                            BuildContext context,
                            AsyncSnapshot snapshot,
                          ) {
                            // 데이터가 없을 때
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Column(
                                children: [
                                  SizedBox(height: 30),
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text(tr('cafeteria.error_message')));
                            } else {
                              speechModel = snapshot.data;
                              getWordContainerList();
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    dividerWithText(
                                        " 분석 결과 ",
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: circleScore(
                                                (speechModel.paragraphAccuracy +
                                                        speechModel
                                                            .paragraphCompleteness +
                                                        speechModel
                                                            .paragraphFluency) ~/
                                                    3,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              "${tr('speech.accuracy')}: ${speechModel.paragraphAccuracy.toInt()}",
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              "${tr('speech.fluency')}: ${speechModel.paragraphFluency.toInt()}",
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              "${tr('speech.completeness')} : ${speechModel.paragraphCompleteness.toInt()}",
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 30),
                                          ],
                                        )),
                                    const SizedBox(height: 30),
                                    dividerWithText(
                                        " ${tr('speech.result_detail')} ",
                                        Column(
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: Column(
                                                children: [
                                                  numErrors(
                                                      const Color(0xFFffcc00),
                                                      " ${tr('speech.wrong_speech')}",
                                                      numWordErrors[0]),
                                                  const SizedBox(height: 10),
                                                  numErrors(
                                                      const Color(0xFF72716F),
                                                      " ${tr('speech.omission')}",
                                                      numWordErrors[1]),
                                                  const SizedBox(height: 10),
                                                  numErrors(
                                                      const Color(0xFFA80000),
                                                      " ${tr('speech.insertion')}",
                                                      numWordErrors[2]),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Column(
                                              children: [
                                                paragraphResult(),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        )),
                                  ],
                                ),
                              );
                            }
                          })
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            tr('speech.guide'),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ),
            ),
            RecorderScreen(
                sentence: sentenceList[0],
                onBtnPressed: () async {
                  setState(() {
                    numWordErrors[0] = 0;
                    numWordErrors[1] = 0;
                    numWordErrors[2] = 0;
                    wordContainerList = [];
                    getSpeechModel = true;
                  });
                }),
          ],
        ),
      ),
    );
  }

  Row numErrors(Color color, String type, int nums) {
    return Row(
      children: [
        Container(
            width: 30,
            color: color,
            child: Text(
              '$nums',
              style: TextStyle(
                  fontSize: 20,
                  color: type == " ${tr('speech.wrong_speech')}"
                      ? Colors.black
                      : Colors.white),
              textAlign: TextAlign.center,
            )),
        Text(
          " $type",
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  SizedBox speechScoreText(String type, double score) {
    return SizedBox(
      width: 190,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$type: ",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "${score.toInt()}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSpeechModel = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    getSpeechModel = false;
    super.dispose();
  }

  Container dividerWithText(String text, Widget childWidget) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffd2d7dd), width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Transform.translate(
            offset: const Offset(0, -27),
            child: Align(
                child: Container(
              color: Colors.white,
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xff929292),
                    fontWeight: FontWeight.w600),
              ),
            )),
          ),
          childWidget,
        ],
      ),
    );
  }

  Stack circleScore(int value) {
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
          ],
        ),
      ],
    );
  }

  Container paragraphResult() {
    return Container(
      child: Wrap(
        runSpacing: 5,
        children: wordContainerList.map((container) => container).toList(),
      ),
    );
  }

  void getWordContainerList() {
    List<dynamic> list = speechModel.wordList;
    for (int i = 0; i < list.length; i++) {
      wordContainerList.insert(i * 2, wordResult(list[i]));
      wordContainerList.insert(
          i * 2 + 1,
          Container(
            child: const Text(" "),
          ));
    }
  }

  Container wordResult(Map<String, dynamic> map) {
    String word = map['word'];
    String errorType = map['errorType'];
    Color textColor = Colors.black;
    Color backgroundColor = Colors.white;

    if (errorType == 'Mispronunciation') {
      numWordErrors[0] += 1;
      backgroundColor = const Color(0xFFffcc00);
    } else if (errorType == 'Omission') {
      numWordErrors[1] += 1;
      textColor = Colors.white;
      backgroundColor = const Color(0xFF72716F);
    } else if (errorType == 'Insertion') {
      numWordErrors[2] += 1;
      textColor = Colors.white;
      backgroundColor = const Color(0xFFA80000);
    }

    return Container(
        color: backgroundColor,
        child: Text(
          word,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
          ),
        ));
  }
}
