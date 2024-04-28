import 'package:capstone_front/models/qna_post_model.dart';

class QnasResponse {
  final List<QnaPostModel> qnas;
  final int? lastCursorId;
  final bool hasNext;

  QnasResponse({
    required this.qnas,
    required this.lastCursorId,
    required this.hasNext,
  });
}
