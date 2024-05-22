class ChatModel {
  int id;
  String content;
  String timestamp;
  String userId;

  ChatModel({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.userId,
  });

  ChatModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        timestamp = json['timestamp'],
        userId = json['user_id'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'timestamp': timestamp,
      'user_id': userId,
    };
  }
}

class ChatModelForChatList extends ChatModel {
  int chatRoomId;

  ChatModelForChatList.fromJson(super.json)
      : chatRoomId = json['chat_room_id'],
        super.fromJson();
}
