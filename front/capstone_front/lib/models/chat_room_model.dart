class ChatRoomModel {
  int chatRoomId;
  String userId;
  String userName;
  int lastMessageId;
  String chatRoomMessage;
  String chatRoomDate;

  ChatRoomModel({
    required this.chatRoomId,
    required this.userId,
    required this.userName,
    required this.lastMessageId,
    required this.chatRoomMessage,
    required this.chatRoomDate,
  });

  ChatRoomModel.fromJson(Map<String, dynamic> json)
      : chatRoomId = json['chatRoomId'],
        userId = json['userId'],
        userName = json['userName'],
        lastMessageId = json['lastMessageId'],
        chatRoomMessage = json['chatRoomMessage'],
        chatRoomDate = json['chatRoomDate'];

  Map<String, dynamic> toJson() {
    return {
      'chatRoomId': chatRoomId,
      'userId': userId,
      'userName': userName,
      'lastMessageId': lastMessageId,
      'chatRoomMessage': chatRoomMessage,
      'chatRoomDate': chatRoomDate,
    };
  }
}
