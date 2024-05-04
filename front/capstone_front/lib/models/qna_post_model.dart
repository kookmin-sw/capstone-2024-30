class QnaPostModel {
  int id;
  String title;
  String author;
  String content;
  String category;
  String country;
  DateTime? datePublished;
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
        imagesList = json['imagesList'] as List<String>;
}

class QnaPostDetailModel extends QnaPostModel {
  List<String> imgUrl;
  DateTime? dateUpdated;
  String uuid;

  QnaPostDetailModel({
    required super.id,
    required super.title,
    required super.author,
    required super.content,
    required super.category,
    required super.country,
    super.datePublished,
    required super.imagesList,
    required super.commentAmount,
    required this.imgUrl,
    this.dateUpdated,
    required this.uuid,
  });

  QnaPostDetailModel.fromJson(Map<String, dynamic> json)
      : imgUrl = json['imgUrl'] as List<String>,
        dateUpdated = json['dateUpdated'] == null
            ? null
            : DateTime.tryParse(json['dateUpdated'] as String),
        uuid = json['uuid'] as String,
        super.fromJson({
          'id': json['id'] as int,
          'title': json['title'] as String,
          'author': json['author'] as String,
          'content': json['content'] as String,
          'category': json['category'] as String,
          'country': json['country'] as String,
          'date_published': json['date_published'] as String?,
          'imagesList': json['imagesList'] as List<String>,
          'commentAmount': json['commentAmount'] as int,
        });
}
