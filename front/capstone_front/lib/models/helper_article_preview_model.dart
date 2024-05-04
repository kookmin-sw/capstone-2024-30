class HelperArticlePreviewModel {
  int id;
  bool isDone;
  bool isHelper;
  String title;
  String author;
  String country;
  String createdDate;

  HelperArticlePreviewModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        isDone = json['isDone'] as bool,
        isHelper = json['isHelper'] as bool,
        title = json['title'] as String,
        author = json['author'] as String,
        country = json['country'] as String,
        createdDate = json['createdDate'] as String;
}
