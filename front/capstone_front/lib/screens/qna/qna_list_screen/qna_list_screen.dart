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

class QnaListScreen extends StatefulWidget {
  const QnaListScreen({super.key});

  @override
  State<QnaListScreen> createState() => _QnaListScreenState();
}

List<Map<String, dynamic>> dummyJsonData() {
  return List.generate(
      10,
      (index) => {
            'id': index,
            'title': "Question ${index + 1}",
            'author': "Author ${index + 1}",
            'content':
                "This is the content for question ${index + 1}. Here you can add more details about the question.",
            'category': "Category ${(index % 5) + 1}",
            'country': "Country ${(index % 3) + 1}",
            'date_published': DateTime.now()
                .subtract(Duration(days: index * 5))
                .toIso8601String(),
            'date_updated': DateTime.now()
                .subtract(Duration(days: index * 3))
                .toIso8601String(),
            'imagesList':
                List.generate(3, (imgIndex) => "image_${index}_$imgIndex.jpg"),
            'commentAmount': (index * 3) % 5,
          });
}

List<QnaPostModel> generateDummyData() {
  List<Map<String, dynamic>> jsonData = dummyJsonData();
  return jsonData.map((json) => QnaPostModel.fromJson(json)).toList();
}

class _QnaListScreenState extends State<QnaListScreen> {
  final _controller = TextEditingController();

  List<QnaPostModel> qnas = [];
  var cursor = 0;
  var hasNext = true;
  var itemCount = 0;

  void loadQnas(int lastCursor) async {
    try {
      QnasResponse res = await QnaService.getQnaPosts(lastCursor, 'all');
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
    qnas = generateDummyData();
    // loadQnas(cursor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: TextField(
          controller: _controller,
          onChanged: (text) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: "검색어를 입력하세요",
            border: InputBorder.none,
            hintStyle: const TextStyle(
              color: Color(0XFFd7d7d7),
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _controller.clear();
                      setState(() {});
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFF8F8F8),
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: qnas.length,
                        itemBuilder: (context, index) {
                          if (index + 1 == itemCount && hasNext) {
                            // loadQnas(cursor);
                          }
                          var post = qnas[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QnaDetailScreen(
                                    data: post,
                                  ),
                                ),
                              );
                            },
                            child: QuestionCard(
                              title: post.title,
                              content: post.content,
                              name: post.author,
                              country: post.country,
                              tag: post.category,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              iconSize: 50,
              onPressed: () {
                context.push('/qnawrite');
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
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
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
      ),
    );
  }
}
