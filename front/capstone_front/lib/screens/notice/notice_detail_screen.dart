import 'package:capstone_front/models/notice_model.dart';
import 'package:capstone_front/services/notice_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class NoticeDetailScreen extends StatefulWidget {
  NoticeModel notice;
  NoticeDetailScreen(this.notice, {super.key});

  @override
  State<NoticeDetailScreen> createState() => _NoticeDetailState();
}

class _NoticeDetailState extends State<NoticeDetailScreen> {
  late Future<NoticeModel> detail;

  @override
  void initState() {
    super.initState();
    detail = NoticeService.getNoticeDetailById(widget.notice.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        // backgroundColor: Theme.of(context).primaryColor,
        // foregroundColor: Colors.white,
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
                    '${widget.notice.author!} (${widget.notice.department!})',
                    style: const TextStyle(
                      color: Color(0xFF646464),
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.notice.type!,
                        style: const TextStyle(
                          color: Color(0xFF8266DF),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.notice.writtenDate!.substring(0, 10),
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
                  // Text(widget.notice.document!),
                  FutureBuilder(
                    future: detail,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return HtmlWidget(snapshot.data!.document!);
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
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
