import 'package:capstone_front/screens/helper/helper_board/helper_board_screen.dart';
import 'package:capstone_front/screens/helper/helper_chatting/helper_chatting_screen.dart';
import 'package:capstone_front/screens/helper/helper_board/helper_writing_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HelperScreen extends StatefulWidget {
  const HelperScreen({super.key});

  @override
  State<HelperScreen> createState() => _HelperScreenState();
}

class _HelperScreenState extends State<HelperScreen> {
  int _selectedPageIndex = 0;
  final _helperScreenList = [
    const HelperBoardScreen(),
    const HelperChattingScreen(),
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
                tr('helper.helper'),
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
                tr('helper.chatting'),
                style: TextStyle(
                  color: _selectedPageIndex == 1 ? Colors.black : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: _helperScreenList.elementAt(_selectedPageIndex),
      ),
    );
  }
}
