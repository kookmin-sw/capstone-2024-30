import 'package:capstone_front/main.dart';
import 'package:capstone_front/models/notice_model.dart';
import 'package:capstone_front/models/notice_response.dart';
import 'package:capstone_front/screens/notice/test_notice_data.dart';
import 'package:capstone_front/screens/notice/notice_detail_screen.dart';
import 'package:capstone_front/services/notice_service.dart';
import 'package:capstone_front/utils/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  String selectedItem = 'all';
  // final _controller = TextEditingController();

  List<NoticeModel> notices = [];
  var cursor = 0;
  var hasNext = true;
  var itemCount = 0;
  bool isSearchMode = false;
  String _word = '';

  void loadNotices(int lastCursor, String language) async {
    try {
      NoticesResponse res =
          await NoticeService.getNotices(lastCursor, selectedItem, language);
      setState(() {
        hasNext = res.hasNext;
        if (hasNext) {
          cursor = res.lastCursorId!;
        }
        notices.addAll(res.notices);
        itemCount += res.notices.length;
      });
    } catch (e) {
      print(e);
      throw Exception('error');
    }
  }

  void loadNoticesByWord(int lastCursor, String language, String word) async {
    try {
      word ??= '';
      NoticesResponse res = await NoticeService.getNoticesByWord(
          lastCursor, selectedItem, language, word);
      setState(() {
        hasNext = res.hasNext;
        if (hasNext) {
          cursor = res.lastCursorId!;
        }
        notices.addAll(res.notices);
        itemCount += res.notices.length;
      });
    } catch (e) {
      print(e);
      throw Exception('error');
    }
  }

  void initLanguageAndLoadNotices() async {
    // const storage = FlutterSecureStorage();
    // String? storedLanguage = await storage.read(key: 'language');
    // var temp = '';
    // if (storedLanguage != "KO") {
    //   temp = 'EN-US';
    // } else {
    //   temp = 'KO';
    // }
    // setState(() {
    //   language = temp;
    // });

    loadNotices(cursor, language);
  }

  void searchNotice(String searchWord) {
    setState(() {
      cursor = 0;
      hasNext = true;
      itemCount = 0;
      notices = [];
      isSearchMode = true;
      _word = searchWord;
    });
    print(_word);
    loadNoticesByWord(cursor, language, _word);
  }

  @override
  void initState() {
    super.initState();
    initLanguageAndLoadNotices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text("공지사항"),
        // title: TextField(
        //   controller: _controller,
        //   onChanged: (text) {
        //     if (text.trim() == "") {
        //       setState(() {
        //         isSearchMode = false;
        //       });
        //     }
        //   },
        //   decoration: InputDecoration(
        //     hintText: "검색어를 입력하세요",
        //     border: InputBorder.none,
        //     hintStyle: const TextStyle(
        //       color: Color(0XFFd7d7d7),
        //     ),
        //     suffixIcon: _controller.text.isNotEmpty
        //         ? IconButton(
        //             onPressed: () {
        //               _controller.clear();
        //               setState(() {
        //                 setState(() {
        //                   cursor = 0;
        //                   hasNext = true;
        //                   itemCount = 0;
        //                   notices = [];
        //                   isSearchMode = false;
        //                 });
        //                 loadNotices(cursor, language);
        //               });
        //             },
        //             icon: const Icon(
        //               Icons.cancel,
        //               color: Colors.grey,
        //             ),
        //           )
        //         : null,
        //   ),
        //   style: const TextStyle(
        //     color: Colors.black,
        //     fontSize: 18.0,
        //   ),
        // ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchScreen(
                          searchCallback: (text) {
                            searchNotice(text);
                          },
                        )),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SizedBox(
              height: 40,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.2,
                    color: const Color(0xFF8266DF),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Wrap(
                              children: <Widget>[
                                ...noticeKinds.map(
                                  (item) => ListTile(
                                    onTap: () {
                                      setState(() {
                                        selectedItem = item;
                                        notices = [];
                                        itemCount = 0;
                                      });
                                      loadNotices(0, language);
                                      Navigator.of(context).pop();
                                    },
                                    title: Center(
                                      child: Text(
                                        item,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        selectedItem,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded)
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  notices = [];
                });
                isSearchMode
                    ? loadNoticesByWord(0, language, _word)
                    : loadNotices(0, language);
              },
              child: ListView.separated(
                itemCount: notices.length,
                itemBuilder: (context, index) {
                  if (index + 1 == itemCount && hasNext) {
                    loadNotices(cursor, language);
                  }
                  var notice = notices[index];
                  return ListTile(
                    title: Text(
                      notice.title!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          notice.type!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF8266DF),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            notice.writtenDate!.substring(0, 10),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFFc8c8c8),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoticeDetailScreen(notice),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Divider(
                    color: Color(0xFFc8c8c8),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
