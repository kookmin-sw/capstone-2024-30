class HelperArticleModel {
  int id;
  bool isDone;
  bool isHelper;
  String title;
  String context;
  String author;
  String country;
  String createdDate;
  String updatedDate;
  String uuid;

  HelperArticleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        isDone = json['isDone'] as bool,
        isHelper = json['isHelper'] as bool,
        title = json['title'] as String,
        context = json['context'] as String,
        author = json['author'] as String,
        country = json['country'] as String,
        createdDate = json['createdDate'] as String,
        updatedDate = json['updatedDate'] as String,
        uuid = json['uuid'] as String;
}
