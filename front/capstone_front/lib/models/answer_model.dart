class AnswerModel {
  int id;
  int questionId;
  String author;
  String content;
  int likeCount;
  String createdDate;
  String updatedDate;
  String uuid;

  AnswerModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        questionId = json['questionId'] as int,
        author = json['author'] as String,
        content = json['context'] as String,
        likeCount = json['likeCount'] as int,
        createdDate =
            json['createdDate'].substring(5, 16).replaceAll('T', ' ') as String,
        updatedDate = json['updatedDate'] ?? "",
        uuid = json['uuid'] ?? "";
}
