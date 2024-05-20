class ChatInitModel {
  String author;
  String uuid;

  ChatInitModel.fromJson(Map<String, dynamic> json)
      : author = json['author'],
        uuid = json['uuid'];
}
