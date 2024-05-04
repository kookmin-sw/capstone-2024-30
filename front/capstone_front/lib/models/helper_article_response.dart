import 'package:capstone_front/models/helper_article_preview_model.dart';

class HelperArticleResponse {
  final List<HelperArticlePreviewModel> articles;
  final int? lastCursorId;
  final bool hasNext;

  HelperArticleResponse({
    required this.articles,
    required this.lastCursorId,
    required this.hasNext,
  });
}
