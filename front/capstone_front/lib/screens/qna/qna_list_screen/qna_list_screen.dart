import 'package:capstone_front/main.dart';
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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

GlobalKey<QnaListScreenState> qnaListScreenGlobalKey = GlobalKey();

class QnaListScreen extends StatefulWidget {
  const QnaListScreen({super.key});

  @override
  State<QnaListScreen> createState() => QnaListScreenState();
}

FlutterSecureStorage storage = const FlutterSecureStorage();

class QnaListScreenState extends State<QnaListScreen> {
  final _controller = TextEditingController();

  List<QnaPostModel> qnas = [];
  int cursor = 0;
  bool hasNext = true;
  int itemCount = 0;
  String? word;
  String? selectedTag;
  String? selectedTagForView;
  // String? language;

  Map<String, String> tagMapEn = {
    "대학생활": "Campus Life",
    "학업관련": "Academics",
    "생활정보": "Living Info",
    "문화정보": "Culture",
    "기숙사": "Dormitory",
  };

  Map<String, String> tagMapZh = {
    "대학생활": "校园生活",
    "학업관련": "学术",
    "생활정보": "生活信息",
    "문화정보": "文化信息",
    "기숙사": "宿舍",
  };

  Map<String, String> tagMapEnToKo = {
    "Campus Life": "대학생활",
    "Academics": "학업관련",
    "Living Info": "생활정보",
    "Culture": "문화정보",
    "Dormitory": "기숙사"
  };

  Map<String, String> tagMapZhToKo = {
    "校园生活": "대학생활",
    "学术": "학업관련",
    "生活信息": "생활정보",
    "文化信息": "문화정보",
    "宿舍": "기숙사"
  };

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

  String translateTagKoToOther(String koreanTag, String nowLanguage) {
    switch (nowLanguage) {
      case 'EN-US':
        return tagMapEn[koreanTag] ?? koreanTag;
      case 'ZH':
        return tagMapZh[koreanTag] ?? koreanTag;
      default:
        return koreanTag;
    }
  }

  String translateTagOtherToKo(String ohterTag, String nowLanguage) {
    switch (nowLanguage) {
      case 'EN-US':
        return tagMapEnToKo[ohterTag] ?? ohterTag;
      case 'ZH':
        return tagMapZhToKo[ohterTag] ?? ohterTag;
      default:
        return ohterTag;
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    // language = await storage.read(key: "language");
    setState(() {});
    await loadQnas(cursor, selectedTag, word);
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
    loadQnas(0, selectedTag, word);
  }

  void selectTag(String tag) {
    tag = translateTagOtherToKo(tag, language);
    setState(() {
      if (selectedTagForView == tag) {
        selectedTagForView = '';
        selectedTag = '';
      } else {
        selectedTag = tag;
        selectedTagForView = tag;
      }
      qnas = [];
      cursor = 0;
      hasNext = true;
      itemCount = 0;
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
              await loadQnas(cursor, selectedTag, word);
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
                              buildSelectableButton(tr('qna.category_1')),
                              const SizedBox(
                                width: 10,
                              ),
                              buildSelectableButton(tr('qna.category_2')),
                              const SizedBox(
                                width: 10,
                              ),
                              buildSelectableButton(tr('qna.category_3')),
                              const SizedBox(
                                width: 10,
                              ),
                              buildSelectableButton(tr('qna.category_4')),
                              const SizedBox(
                                width: 10,
                              ),
                              buildSelectableButton(tr('qna.category_5')),
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
                              loadQnas(cursor, selectedTag, word);
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
                                  tag: translateTagKoToOther(
                                      post.category, language),
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
                  extra: {
                    'selectedTag': selectedTag,
                    'qnas': qnas,
                  },
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
    final bool isSelected =
        selectedTagForView == translateTagOtherToKo(tag, language ?? "KO");
    return ElevatedButton(
      onPressed: () {
        selectTag(tag);
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: isSelected ? Colors.white : const Color(0xFF8266DF),
        backgroundColor: isSelected ? const Color(0xFF8266DF) : Colors.white,
        side: const BorderSide(
          color: Color(0xFF8266DF),
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF8266DF),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
