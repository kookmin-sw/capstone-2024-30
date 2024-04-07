import 'package:capstone_front/screens/notice_detail/notice_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

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
      'title': '미래혁신단(차세대통신사업단) 직원 모집',
      'kind': '교내채용',
      'date': '2024-04-05',
    },
    {
      'title': '국민대학교 비전임교원 채용(2024.05.01.자)',
      'kind': '교내채용',
      'date': '2024-04-05',
    },
    {
      'title': '(진로지원센터) 계약직원 모집',
      'kind': '교내채용',
      'date': '2024-04-04',
    },
    {
      'title': '(대외협력팀) 계약직원 모집',
      'kind': '교내채용',
      'date': '2024-04-04',
    },
    {
      'title': '[장학공지] 2024학년도 1학기 남윤철장학금 신청 안내',
      'kind': '장학공지',
      'date': '2024-04-04',
    },
    {
      'title': '[장학공지] 2024학년도 1학기 가온누리장학금 신청 안내',
      'kind': '장학공지',
      'date': '2024-04-04',
    },
    {
      'title': '[장학공지] 2024학년도 1학기 어울림장학금 신청 안내',
      'kind': '장학공지',
      'date': '2024-04-04',
    },
    {
      'title': '[장학공지] 2024학년도 1학기 그린나래장학금 신청 안내',
      'kind': '장학공지',
      'date': '2024-04-04',
    },
    {
      'title': '[장학공지] 2024학년도 1학기 메시장학금 신청 안내',
      'kind': '장학공지',
      'date': '2024-04-03',
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
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
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
                      // context.push("/notice/detail");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoticeDetail(posts[index]),
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
      ),
    );
  }
}
