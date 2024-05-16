import 'package:capstone_front/models/qna_post_model.dart';
import 'package:capstone_front/models/qna_response.dart';
import 'package:capstone_front/screens/qna/qna_detail/qna_detail_screen.dart';
import 'package:capstone_front/screens/qna/qna_list_screen/question_card.dart';
import 'package:capstone_front/screens/qna/qna_list_screen/test_question_data.dart';
import 'package:capstone_front/services/qna_service.dart';
import 'package:capstone_front/utils/basic_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

GlobalKey<_QnaListScreenState> qnaListScreenGlobalKey = GlobalKey();

class QnaListScreen extends StatefulWidget {
  const QnaListScreen({super.key});

  @override
  State<QnaListScreen> createState() => _QnaListScreenState();
}

class _QnaListScreenState extends State<QnaListScreen> {
  final _controller = TextEditingController();

  List<QnaPostModel> qnas = [];
  int cursor = 0;
  bool hasNext = true;
  int itemCount = 0;
  String? word;
  String? tag;
  String selectedTag = '';

  Future<void> loadQnas(int lastCursor, String? tag, String? word) async {
    try {
      QnasResponse res = await QnaService.getQnaPosts(lastCursor, tag, word);
      setState(() {
        hasNext = res.hasNext;
        if (hasNext) {
          cursor = res.lastCursorId!;
        }
        qnas.addAll(res.qnas);
        itemCount += res.qnas.length;
      });
    } catch (e) {
      print(e);
      throw Exception('error');
    }
  }

  @override
  void initState() {
    super.initState();
    loadQnas(cursor, tag, word);
  }

  void searchQna(String searchWord) {
    print('...................................');
    print(searchWord);
    setState(() {
      qnas = [];
      cursor = 0;
      hasNext = true;
      itemCount = 0;
      word = searchWord;
    });
    loadQnas(0, tag, word);
  }

  void selectTag(String tag) {
    setState(() {
      if (selectedTag == tag) {
        selectedTag = '';
      } else {
        selectedTag = tag;
      }
    });
    setState(() {
      qnas = [];
      cursor = 0;
      hasNext = true;
      itemCount = 0;
      word = null;
    });
    loadQnas(0, selectedTag, word);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              setState(() {
                cursor = 0;
                hasNext = true;
                itemCount = 0;
              });
              qnas = [];
              await loadQnas(cursor, tag, word);
            },
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              buildSelectableButton("학사안내"),
                              const SizedBox(
                                width: 10,
                              ),
                              buildSelectableButton("대학생활"),
                              const SizedBox(
                                width: 10,
                              ),
                              buildSelectableButton("교직원안내"),
                              const SizedBox(
                                width: 10,
                              ),
                              buildSelectableButton("교수자"),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(), // 부모 스크롤뷰가 스크롤을 관리하도록 함
                          itemCount: qnas.length,
                          itemBuilder: (context, index) {
                            if (index + 1 == itemCount && hasNext) {
                              loadQnas(cursor, tag, word);
                            }
                            var post = qnas[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QnaDetailScreen(
                                      postModel: post,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  top: 5,
                                  bottom: 10,
                                ),
                                child: QuestionCard(
                                  title: post.title,
                                  content: post.content,
                                  name: post.author,
                                  country: post.country,
                                  tag: post.category,
                                  answerCount: post.answerCount,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              iconSize: 50,
              onPressed: () async {
                var result = await context.push(
                  '/qnawrite',
                  extra: qnas,
                );
                setState(() {});
              },
              style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectableButton(String tag) {
    final bool isSelected = selectedTag == tag;
    return ElevatedButton(
      onPressed: () {
        selectTag(tag);
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: isSelected ? Colors.white : const Color(0xff6E2FF4),
        backgroundColor: isSelected ? const Color(0xff6E2FF4) : Colors.white,
        side: const BorderSide(
          color: Color(0xff6E2FF4),
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xff6E2FF4),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class MyCustomBottomSheet extends StatefulWidget {
  const MyCustomBottomSheet({super.key});

  @override
  _MyCustomBottomSheetState createState() => _MyCustomBottomSheetState();
}

class _MyCustomBottomSheetState extends State<MyCustomBottomSheet> {
  bool productInfo = false;
  bool ingredientInfo = false;
  bool nutritionAnalysis = false;
  bool others = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // 컨텐츠 크기에 맞춰 조정
      children: <Widget>[
        Text(
          tr('qna.writetitle'),
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 30,
        ),
        CheckboxListTile(
          title: Text(tr('qna.category_1')),
          value: productInfo,
          activeColor: Theme.of(context).primaryColor,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            setState(() {
              productInfo = value!;
            });
          },
        ),
        const Divider(
          color: Color(0xFFc9c9c9),
        ),
        CheckboxListTile(
          title: Text(tr('qna.category_2')),
          value: ingredientInfo,
          activeColor: Theme.of(context).primaryColor,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            setState(() {
              ingredientInfo = value!;
            });
          },
        ),
        const Divider(
          color: Color(0xFFc9c9c9),
        ),
        CheckboxListTile(
          title: Text(tr('qna.category_3')),
          value: nutritionAnalysis,
          activeColor: Theme.of(context).primaryColor,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            setState(() {
              nutritionAnalysis = value!;
            });
          },
        ),
        const Divider(
          color: Color(0xFFc9c9c9),
        ),
        CheckboxListTile(
          title: Text(tr('qna.category_4')),
          value: others,
          activeColor: Theme.of(context).primaryColor,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            setState(() {
              others = value!;
            });
          },
        ),
        const SizedBox(
          height: 30,
        ),
        BasicButton(
          text: "선택완료",
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
