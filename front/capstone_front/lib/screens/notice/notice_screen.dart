import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  List<String> items = ['전체공지', '학사공지', '장학공지'];
  String selectedItem = '전체공지';
  final _controller = TextEditingController();

  final List<Map<String, dynamic>> posts = [
    {
      'title': '게시글 제목 1',
      'kind': '학사공지',
      'date': '2024-04-01',
    },
    {
      'title': '게시글 제목 2',
      'kind': '장학공지',
      'date': '2024-04-02',
    },
    {
      'title': '게시글 제목 2',
      'kind': '장학공지',
      'date': '2024-04-02',
    },
    {
      'title': '게시글 제목 2',
      'kind': '장학공지',
      'date': '2024-04-02',
    },
    {
      'title': '게시글 제목 2',
      'kind': '장학공지',
      'date': '2024-04-02',
    },
    {
      'title': '게시글 제목 2',
      'kind': '장학공지',
      'date': '2024-04-02',
    },
    {
      'title': '게시글 제목 2',
      'kind': '장학공지',
      'date': '2024-04-02',
    },
    {
      'title': '게시글 제목 2',
      'kind': '장학공지',
      'date': '2024-04-02',
    },
    {
      'title': '게시글 제목 2',
      'kind': '장학공지',
      'date': '2024-04-02',
    },
    // 추가 게시글 데이터를 여기에 넣을 수 있습니다.
  ];

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
          ElevatedButton(
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
                    child: Wrap(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.notifications),
                          title: const Text('전체공지'),
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() {
                              selectedItem = "전체공지";
                            });
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.message),
                          title: const Text('장학공지'),
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() {
                              selectedItem = "장학공지";
                            });
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.school),
                          title: const Text('학사공지'),
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() {
                              selectedItem = "학사공지";
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Text(selectedItem),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    posts[index]['title'],
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        posts[index]['kind'],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        posts[index]['date'],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey, // 여기에서 구분선 색상을 지정할 수 있습니다.
              ),
            ),
          )
        ],
      ),
    );
  }
}
