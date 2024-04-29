class ChatModel {
  int id;
  String content;
  String timestamp;

  ChatModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        timestamp = json['timestamp'];
}

class ChatModelForChatList extends ChatModel {
  int chatRoomId;

  ChatModelForChatList.fromJson(super.json)
      : chatRoomId = json['chatRoomId'],
        super.fromJson();
}
