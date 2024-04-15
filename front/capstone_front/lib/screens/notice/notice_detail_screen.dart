import 'package:capstone_front/models/notice_model.dart';
import 'package:flutter/material.dart';

class NoticeDetailScreen extends StatefulWidget {
  NoticeModel notice;
  NoticeDetailScreen(this.notice, {super.key});

  @override
  State<NoticeDetailScreen> createState() => _NoticeDetailState();
}

class _NoticeDetailState extends State<NoticeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          widget.notice.department!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.notice.title!),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.notice.author!,
                    style: const TextStyle(
                      color: Color(0xFF646464),
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.notice.department!,
                        style: const TextStyle(
                          color: Color(0xFF8266DF),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.notice.createdDate!.substring(0, 10),
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
                      border: Border.all(
                          width: 0.8, color: const Color(0xFFF3F3F3)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(widget.notice.document!),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.8, color: const Color(0xFFF3F3F3)),
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
      ),
    );
  }
}
