class ChatModel {
  final String chatId;
  final String lastMessage;
  final String lastMessageSenderId;
  final DateTime lastMessageTime;
  final List<String> participants;

  // 🔥 UI-only fields (NOT stored in Firestore)
  String? otherUserName;
  String? otherUserPhoto;


  ChatModel({
    required this.chatId,
    required this.lastMessage,
    required this.lastMessageSenderId,
    required this.lastMessageTime,
    required this.participants,
    this.otherUserName,
    this.otherUserPhoto,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatId: map['chatId'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      lastMessageSenderId: map['lastMessageSenderId'] ?? '',
      lastMessageTime: map['lastMessageTime'] != null
          ? (map['lastMessageTime'] as dynamic).toDate()
          : DateTime.now(),
      participants: List<String>.from(map['participants'] ?? []),
    );
  }
}
