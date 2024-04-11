import 'package:capstone_front/screens/qna/qna_detail/qna_detail_screen.dart';
import 'package:capstone_front/screens/qna/qna_list_screen/question_card.dart';
import 'package:capstone_front/screens/qna/qna_list_screen/test_question_data.dart';
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

class _QnaListScreenState extends State<QnaListScreen> {
  final _controller = TextEditingController();

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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ...questionDatas.map(
                        (item) => Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QnaDetailScreen(
                                      data: item,
                                    ),
                                  ),
                                );
                              },
                              child: QuestionCard(
                                title: item['title'],
                                content: item['content'],
                                name: item['name'],
                                country: item['country'],
                                tag: item['tag'],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
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
