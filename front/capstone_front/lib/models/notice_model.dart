class NoticeModel {
  String? createdDate;
  String? modifiedDate;
  int? id;
  String? type;
  String? title;
  String? writtenDate;
  String? department;
  String? author;
  String? authorPhone;
  String? document;
  String? language;
  String? url;
  List<dynamic>? files;

  NoticeModel.fromJson(Map<String, dynamic> json)
      : createdDate = json['createdDate'],
        modifiedDate = json['modifiedDate'],
        id = json['id'],
        type = json['type'],
        title = json['title'],
        writtenDate = json['writtenDate'],
        department = json['department'],
        author = json['author'],
        authorPhone = json['authorPhone'],
        document = json['document'],
        language = json['language'],
        url = json['url'],
        files = json['files'];
}
