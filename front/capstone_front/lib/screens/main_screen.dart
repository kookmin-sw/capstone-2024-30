import 'package:capstone_front/screens/helper/helper_screen.dart';
import 'package:capstone_front/screens/home/home_screen.dart';
import 'package:capstone_front/screens/notice/notice_screen.dart';
import 'package:capstone_front/screens/qna/qna_list_screen/qna_list_screen.dart';
import 'package:capstone_front/screens/speech_practice/speech_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final screenList = [
    const NoticeScreen(),
    const QnaListScreen(),
    const HomeScreen(),
    const HelperScreen(),
    const SpeechScreen(),
  ];
  int selectedPageIndex = 2;
  @override
  DateTime? backButtonPressedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(selectedPageIndex),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.article),
              label: tr('mainScreen.notice'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.help_center_outlined),
              label: tr('mainScreen.qna'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: tr('mainScreen.home'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.people),
              label: tr('mainScreen.helper'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.type_specimen_sharp),
              label: tr('mainScreen.pronunciation_practice'),
            ),
          ],
          currentIndex: selectedPageIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: (value) {
            setState(() {
              selectedPageIndex = value;
            });
          },
        ),
      ),
    );
  }

  // void _goBack(BuildContext context) async {
  //   DateTime currentTime = DateTime.now();

  //   if (backButtonPressedTime == null ||
  //       currentTime.difference(backButtonPressedTime!) >
  //           const Duration(seconds: 2)) {
  //     backButtonPressedTime = currentTime;
  //     Fluttertoast.showToast(
  //       msg: "뒤로가기 버튼을 한번 더 누르면 종료됩니다.",
  //       gravity: ToastGravity.BOTTOM,
  //     );
  //   } else {
  //     SystemNavigator.pop();
  //   }
  // }
}
