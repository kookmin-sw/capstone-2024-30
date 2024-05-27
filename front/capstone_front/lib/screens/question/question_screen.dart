import 'package:capstone_front/screens/faq/faq_screen.dart';
import 'package:capstone_front/screens/qna/qna_list_screen/qna_list_screen.dart';
import 'package:capstone_front/utils/search_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GlobalKey<QnaListScreenState> qnaListScreenGlobalKey = GlobalKey();
GlobalKey<FaqScreenState> faqScreenGlobalKey = GlobalKey();

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _selectedPageIndex = 0;
  late List<Widget> _qnaScreenList;
  late FaqScreen faqScreen;

  String qnaSearchWord = '';
  String faqSearchWord = '';
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    faqScreen = FaqScreen(
      key: faqScreenGlobalKey,
      performSearch: (text) {
        _performSearch(text);
      },
      searchController: _searchController, // 추가된 부분
    );
    _qnaScreenList = [
      QnaListScreen(key: qnaListScreenGlobalKey),
      faqScreen,
    ];
  }

  void _clearSearch() {
    setState(() {
      if (_selectedPageIndex == 0) {
        qnaSearchWord = '';
        qnaListScreenGlobalKey.currentState?.searchQna('');
      } else {
        faqSearchWord = '';
        faqScreenGlobalKey.currentState?.filterFaqs('');
        _searchController.clear();
      }
    });
  }

  void _performSearch(String text) {
    setState(() {
      if (_selectedPageIndex == 0) {
        qnaSearchWord = text;
        qnaListScreenGlobalKey.currentState?.searchQna(text);
      } else {
        faqSearchWord = text;
        faqScreenGlobalKey.currentState?.filterFaqs(text);
      }
    });
  }

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
                  _clearSearch();
                });
              },
              child: Text(
                "QnA",
                style: TextStyle(
                  color: _selectedPageIndex == 0 ? Colors.black : Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPageIndex = 1;
                  _clearSearch();
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
          if (_selectedPageIndex == 0 && qnaSearchWord.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Chip(
                label: Text(
                  qnaSearchWord,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: const Color(0xFF6E2FF4),
                deleteIcon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18,
                ),
                onDeleted: _clearSearch,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide.none,
              ),
            ),
          if (_selectedPageIndex == 1)
            SizedBox(
              width: 200,
              child: TextField(
                controller: _searchController,
                onChanged: (text) {
                  _performSearch(text);
                },
                decoration: InputDecoration(
                  hintText: tr('qna.search_hint'),
                  border: InputBorder.none,
                  hintStyle: const TextStyle(
                    color: Color(0XFFd7d7d7),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _clearSearch();
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.grey,
                          ),
                        )
                      : null,
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              if (_selectedPageIndex == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(
                      searchCallback: (text) {
                        _performSearch(text);
                      },
                    ),
                  ),
                );
              }
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
