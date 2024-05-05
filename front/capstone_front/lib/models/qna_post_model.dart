class QnaPostModel {
  int id;
  String title;
  String author;
  String content;
  String category;
  String country;
  String createdDate;
  int answerCount;

  QnaPostModel({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.category,
    required this.country,
    required this.createdDate,
    required this.answerCount,
  });

  QnaPostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        title = json['title'] as String,
        author = json['author'] as String,
        content = json['context'] as String,
        category = json['tag'] as String,
        country = json['country'] as String,
        answerCount = json['answerCount'] as int,
        createdDate = json['createdDate'] as String;
}

class QnaPostDetailModel {
  int id;
  String title;
  String author;
  String content;
  String category;
  String country;
  String createdDate;
  String uuid;
  List<String> imgUrl;

  QnaPostDetailModel.fromJson(Map<String, dynamic> json)
      : id = json['questionResponse']['id'] as int,
        title = json['questionResponse']['title'] as String,
        author = json['questionResponse']['author'] as String,
        content = json['questionResponse']['context'] as String,
        category = json['questionResponse']['tag'] as String,
        country = json['questionResponse']['country'] as String,
        createdDate = json['questionResponse']['createdDate'] as String,
        uuid = json['questionResponse']['uuid'] as String,
        imgUrl = (json['imgUrl'] as List<dynamic>)
            .map((item) => item as String)
            .toList();
}
