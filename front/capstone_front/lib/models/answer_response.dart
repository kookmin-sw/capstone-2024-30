import 'package:capstone_front/models/answer_model.dart';
import 'package:capstone_front/models/qna_post_model.dart';

class AnswerResponse {
  final List<AnswerModel> answers;
  final int? lastCursorId;
  final bool hasNext;

  AnswerResponse({
    required this.answers,
    required this.lastCursorId,
    required this.hasNext,
  });
}
