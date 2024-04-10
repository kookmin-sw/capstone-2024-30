import 'package:capstone_front/screens/helper/helper_board_screen.dart';
import 'package:capstone_front/screens/helper/helper_chatting_screen.dart';
import 'package:capstone_front/screens/helper/helper_writing_screen.dart';
import 'package:flutter/material.dart';

class HelperScreen extends StatefulWidget {
  const HelperScreen({super.key});

  @override
  State<HelperScreen> createState() => _HelperScreenState();
}

class _HelperScreenState extends State<HelperScreen> {
  int _selectedPageIndex = 0;
  final _helperWidgetList = [
    const HelperBoardScreen(),
    const HelperChattingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _helperWidgetList.elementAt(_selectedPageIndex),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.article), label: '게시판'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: '채팅'),
          ],
          currentIndex: _selectedPageIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          onTap: (value) {
            setState(() {
              _selectedPageIndex = value;
            });
          },
        ),
      ),
    );
  }
}
