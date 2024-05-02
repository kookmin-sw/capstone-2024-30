class ChatModel {
  int id;
  String content;
  String timestamp;

  ChatModel({
    required this.id,
    required this.content,
    required this.timestamp,
  });

  ChatModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        timestamp = json['timestamp'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'timestamp': timestamp,
    };
  }
}

class ChatModelForChatList extends ChatModel {
  int chatRoomId;

  ChatModelForChatList.fromJson(super.json)
      : chatRoomId = json['chatRoomId'],
        super.fromJson();
}
