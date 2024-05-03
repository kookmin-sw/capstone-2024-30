import 'package:capstone_front/screens/faq/faq_screen.dart';
import 'package:capstone_front/screens/qna/qna_list_screen/qna_list_screen.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _selectedPageIndex = 0;
  final _qnaScreenList = [
    const QnaListScreen(),
    const FaqScreen(),
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
                "QnA",
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
                "FAQ",
                style: TextStyle(
                  color: _selectedPageIndex == 1 ? Colors.black : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: _qnaScreenList.elementAt(_selectedPageIndex),
      ),
    );
  }
}
