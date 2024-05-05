class ChatRoomModel {
  int chatRoomId;
  String userId;
  String userName;
  int lastMessageId;
  int lastMessagePreviewId;
  String chatRoomMessage;
  String chatRoomDate;

  ChatRoomModel({
    required this.chatRoomId,
    required this.userId,
    required this.userName,
    required this.lastMessageId,
    required this.lastMessagePreviewId,
    required this.chatRoomMessage,
    required this.chatRoomDate,
  });

  ChatRoomModel.fromJson(Map<String, dynamic> json)
      : chatRoomId = json['chat_room_id'],
        userId = json['user_id'],
        userName = json['user_name'],
        lastMessageId = json['last_message_id'] ?? 0,
        lastMessagePreviewId = json['last_message_preview_id'] ?? 0,
        chatRoomMessage = json['chat_room_message'] ?? "",
        chatRoomDate = json['chat_room_date'] ?? "";

  Map<String, dynamic> toJson() {
    return {
      'chat_room_id': chatRoomId,
      'user_id': userId,
      'user_name': userName,
      'last_message_id': lastMessageId,
      'last_message_preview_id': lastMessagePreviewId,
      'chat_room_message': chatRoomMessage,
      'chat_room_date': chatRoomDate,
    };
  }
}
