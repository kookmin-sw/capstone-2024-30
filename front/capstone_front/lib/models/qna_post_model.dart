class QnaPostModel {
  int id;
  String title;
  String author;
  String mainText;
  DateTime? datePublished;
  DateTime? dateUpdated;
  int view;
  String email;

  QnaPostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        title = json['title'] as String,
        author = json['author'] as String,
        mainText = json['mainText'] as String,
        datePublished = json['date_published'] == null
            ? null
            : DateTime.tryParse(json['date_published'] as String),
        dateUpdated = json['date_updated'] == null
            ? null
            : DateTime.tryParse(json['date_updated'] as String),
        view = json['view'] as int,
        email = json['email'] as String;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'mainText': mainText,
      'date_published': datePublished,
      'date_updated': dateUpdated,
      'view': view,
      'email': email,
    };
  }
}
