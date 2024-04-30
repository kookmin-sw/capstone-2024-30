class QnaPostModel {
  int id;
  String title;
  String author;
  String content;
  String category;
  String country;
  DateTime? datePublished;
  DateTime? dateUpdated;
  List<String> imagesList;
  int commentAmount;

  QnaPostModel({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.category,
    required this.country,
    this.datePublished,
    this.dateUpdated,
    required this.imagesList,
    required this.commentAmount,
  });

  QnaPostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        title = json['title'] as String,
        author = json['author'] as String,
        content = json['content'] as String,
        category = json['category'] as String,
        country = json['country'] as String,
        commentAmount = json['commentAmount'] as int,
        datePublished = json['date_published'] == null
            ? null
            : DateTime.tryParse(json['date_published'] as String),
        dateUpdated = json['date_updated'] == null
            ? null
            : DateTime.tryParse(json['date_updated'] as String),
        imagesList = json['imagesList'] as List<String>;
}