import 'package:flutter/material.dart';

class NoticeDetail extends StatefulWidget {
  Map<String, dynamic> post;
  NoticeDetail(this.post, {super.key});

  @override
  State<NoticeDetail> createState() => _NoticeDetailState();
}

class _NoticeDetailState extends State<NoticeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          widget.post['kind'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.post['title']),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "최지훈 (차세대통신사업단)",
                  style: TextStyle(
                    color: Color(0xFF646464),
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      widget.post['kind'],
                      style: const TextStyle(
                        color: Color(0xFF8266DF),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.post['date'],
                      style: const TextStyle(
                        color: Color(0xFF646464),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 0.8, color: const Color(0xFFF3F3F3)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("본문 내용 입니다.\n본문 내용 입니다.\n본문 내용 입니다.\n본문 내용 입니다.\n"),
                Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 0.8, color: const Color(0xFFF3F3F3)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "첨부파일 1개",
                  style: TextStyle(
                    color: Color(0xFF646464),
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
