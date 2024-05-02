import 'package:capstone_front/screens/speech_practice/utils/audio_player.dart';
import 'package:capstone_front/screens/speech_practice/utils/audio_recorder.dart';
import 'package:capstone_front/services/speech_service.dart';
import 'package:flutter/material.dart';

class RecorderScreen extends StatefulWidget {
  final String sentence;
  const RecorderScreen({super.key, required this.sentence});

  @override
  State<RecorderScreen> createState() => _RecorderScreenState();
}

class _RecorderScreenState extends State<RecorderScreen> {
  bool showPlayer = false;
  String? audioPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black, width: 2))),
      child: showPlayer
          ? Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
              child: AudioPlayer(
                source: audioPath!,
                onDelete: () {
                  setState(() => showPlayer = false);
                },
                path: audioPath!,
                sentence: widget.sentence,
              ),
            )
          : Recorder(
              onStop: (path) {
                print('Recorded file path: $path');
                setState(() {
                  audioPath = path;
                  showPlayer = true;
                });
              },
            ),
    );
    //     return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Column(
    //       children: [

    //         Transform.translate(
    //           offset: const Offset(0, -10),
    //           child: const Text(
    //             "나의 발음",
    //             style: TextStyle(fontSize: 16),
    //           ),
    //         ),
    //       ],
    //     ),
    //     Transform.translate(
    //       offset: const Offset(0, -40),
    //       child: Container(
    //         decoration: BoxDecoration(
    //           shape: BoxShape.circle,
    //           color: Theme.of(context).colorScheme.primary,
    //         ),
    //         child: IconButton(
    //           iconSize: 60,
    //           onPressed: () {},
    //           icon: showPlayer
    //               ? const Icon(
    //                   Icons.stop,
    //                   color: Colors.white,
    //                 )
    //               : Icon(
    //                   Icons.mic,
    //                   color: showPlayer ? Colors.grey[300] : Colors.white,
    //                 ),
    //         ),
    //       ),
    //     ),
    //     Column(
    //       children: [
    //         IconButton(
    //             iconSize: 50,
    //             onPressed: () async {
    //               String result =
    //                   await getSpeechResult(audioPath!, widget.sentence);
    //               print(result);
    //             },
    //             //color: Colors.white,
    //             //disabledColor: Colors.grey,
    //             icon: const Icon(Icons.check)),
    //         Transform.translate(
    //           offset: const Offset(0, -10),
    //           child: const Text(
    //             "결과 확인",
    //             style: TextStyle(fontSize: 16),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
