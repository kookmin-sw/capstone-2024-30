import 'package:capstone_front/models/notice_model.dart';

class NoticesResponse {
  final List<NoticeModel> notices;
  final int? lastCursorId;
  final bool hasNext;

  NoticesResponse({
    required this.notices,
    required this.lastCursorId,
    required this.hasNext,
  });
}
