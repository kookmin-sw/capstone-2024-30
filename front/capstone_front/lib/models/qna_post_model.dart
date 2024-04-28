class QnaPostModel {
  int id;
  String title;
  String author;
  String content;
  DateTime? datePublished;
  DateTime? dateUpdated;
  List<String> imagesList;
  int commentAmount;

  QnaPostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        title = json['title'] as String,
        author = json['author'] as String,
        content = json['content'] as String,
        commentAmount = json['commentAmount'] as int,
        datePublished = json['date_published'] == null
            ? null
            : DateTime.tryParse(json['date_published'] as String),
        dateUpdated = json['date_updated'] == null
            ? null
            : DateTime.tryParse(json['date_updated'] as String),
        imagesList = json['imagesList'] as List<String>;
}
