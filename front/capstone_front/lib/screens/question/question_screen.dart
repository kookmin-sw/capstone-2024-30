import 'package:capstone_front/screens/faq/faq_screen.dart';
import 'package:capstone_front/screens/qna/qna_list_screen/qna_list_screen.dart';
import 'package:capstone_front/utils/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:capstone_front/screens/qna/qna_list_screen/qna_list_screen.dart';
import 'package:go_router/go_router.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _selectedPageIndex = 0;
  final _qnaScreenList = [
    QnaListScreen(key: qnaListScreenGlobalKey),
    const FaqScreen(),
  ];

  String qnaSearchWord = 'what';

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
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              // QNA 검색
              if (_selectedPageIndex == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchScreen(
                            searchCallback: (text) {
                              qnaListScreenGlobalKey.currentState
                                  ?.searchQna(text);
                            },
                          )),
                );
              }
              // FAQ 검색
              else {}
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _qnaScreenList.elementAt(_selectedPageIndex),
      ),
    );
  }
}
