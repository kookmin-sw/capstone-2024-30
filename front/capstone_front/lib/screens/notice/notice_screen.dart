import 'package:capstone_front/screens/notice/test_notice_data.dart';
import 'package:capstone_front/screens/notice_detail/notice_detail_screen.dart';
import 'package:flutter/material.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  List<String> items = ['전체공지', '학사공지', '장학공지'];
  String selectedItem = '전체공지';
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SizedBox(
              height: 50,
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
                                      });
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
            child: ListView.separated(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    posts[index]['title'],
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        posts[index]['kind'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF8266DF),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        posts[index]['date'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFFc8c8c8),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoticeDetailScreen(posts[index]),
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
          )
        ],
      ),
    );
  }
}