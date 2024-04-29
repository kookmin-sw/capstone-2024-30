class ChatRoomModel {
  int chatRoomId;
  String userId;
  String userName;
  int lastMessageId;
  String chatRoomMessage;
  String chatRoomDate;

  ChatRoomModel.fromJson(Map<String, dynamic> json)
      : chatRoomId = json['chatRoomId'],
        userId = json['userId'],
        userName = json['userName'],
        lastMessageId = json['lastMessageId'],
        chatRoomMessage = json['chatRoomMessage'],
        chatRoomDate = json['chatRoomDate'];
}
