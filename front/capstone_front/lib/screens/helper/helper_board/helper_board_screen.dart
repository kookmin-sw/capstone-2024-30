import 'package:capstone_front/models/helper_article_preview_model.dart';
import 'package:capstone_front/screens/helper/helper_board/helper_writing_card.dart';
import 'package:capstone_front/screens/helper/helper_board/helper_writing_json.dart';
import 'package:capstone_front/screens/helper/helper_write_screen.dart';
import 'package:capstone_front/services/helper_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class HelperBoardScreen extends StatefulWidget {
  const HelperBoardScreen({super.key});

  @override
  State<HelperBoardScreen> createState() => _HelperBoardState();
}

class _HelperBoardState extends State<HelperBoardScreen> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  late List<HelperArticlePreviewModel> helperArticlePreviews = [];
  int cursor = 0;
  bool isHelper = false;
  bool isDone = false;
  bool hasNext = false;
  String? uuid = "";
  var itemCount = 0;
  int _selectedHelperIndex = 0;
  bool searchMyArticles = false;

  final List<String> _helperList = [
    tr('helper.need_helper'),
    tr('helper.need_helpee'),
  ];

  Future<void> loadHelperAtricles() async {
    uuid = null;
    if (searchMyArticles) {
      uuid = await storage.read(key: "uuid");
    }
    var res =
        await HelperService.getHelperAtricles(cursor, isHelper, isDone, uuid);
    helperArticlePreviews.addAll(res.articles);
    hasNext = res.hasNext;
    if (res.hasNext) {
      cursor = res.lastCursorId!;
    }
    itemCount += res.articles.length;
    setState(() {});
  }

  Future<void> initStateForChangeType() async {
    setState(() {
      cursor = 0;
      isDone = false;
      hasNext = false;
      itemCount = 0;
      helperArticlePreviews = [];
    });
  }

  @override
  void initState() {
    loadHelperAtricles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: selectWritingType(context),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: helperArticlePreviews.length,
                  itemBuilder: (context, index) {
                    if (index + 1 == itemCount && hasNext) {
                      loadHelperAtricles();
                    }
                    return HelperWritingCard(
                      helperArticlePreviewModel: helperArticlePreviews[index],
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              iconSize: 50,
              onPressed: () async {
                var articleObj = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HelperWriteScreen(),
                  ),
                );
                if (articleObj != null) {
                  if (isHelper == articleObj.isHelper) {
                    helperArticlePreviews.insert(
                      0,
                      HelperArticlePreviewModel.fromJson(
                        {
                          "id": articleObj.id,
                          "isDone": articleObj.isDone,
                          "isHelper": articleObj.isHelper,
                          "title": articleObj.title,
                          "author": articleObj.author,
                          "country": articleObj.country,
                          "createdDate": articleObj.createdDate,
                        },
                      ),
                    );
                  }
                  setState(() {});
                }
              },
              style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          // Positioned(
          //   bottom: 20,
          //   right: 0,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       border: Border.all(
          //         color: Theme.of(context).colorScheme.primary,
          //         width: 3,
          //       ),
          //     ),
          //     child: IconButton(
          //       iconSize: 50,
          //       onPressed: () {},
          //       style: IconButton.styleFrom(
          //         backgroundColor: Colors.white,
          //       ),
          //       icon: Icon(
          //         Icons.add,
          //         color: Theme.of(context).colorScheme.primary,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Row selectWritingType(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width - 40,
          height: 40,
          alignment: Alignment.centerLeft,
          child: ListView.builder(
            itemCount: _helperList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 0 : 10),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      _selectedHelperIndex = index;
                      isHelper = _selectedHelperIndex == 0 ? false : true;
                    });
                    await initStateForChangeType();
                    await loadHelperAtricles();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: _selectedHelperIndex == index
                          ? const Color(0xb4000000)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: _selectedHelperIndex == index
                          ? Border.all(
                              color: const Color(0x00000000),
                              width: 1.5,
                            )
                          : Border.all(
                              color: const Color(0xffE4E7EB), width: 1.5),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _helperList[index],
                        style: _selectedHelperIndex == index
                            ? const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                              )
                            : const TextStyle(
                                color: Color(0xFF464D57),
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                              ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
