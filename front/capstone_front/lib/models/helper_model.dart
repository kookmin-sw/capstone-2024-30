class HelperModel {
  String author;
  String uuid;
  String department;
  String title;
  String content;
  String writtenDate;

  HelperModel.fromJson(Map<String, dynamic> json)
      : author = json['author'],
        uuid = json['uuid'],
        department = json['department'],
        title = json['title'],
        content = json['content'],
        writtenDate = json['writtenDate'];
}
