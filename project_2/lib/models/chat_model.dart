import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  // 🔥 Firestore fields
  final String chatId;
  final String lastMessage;
  final String lastMessageSenderId;
  final DateTime lastMessageTime;
  final List<String> participants;

  // 🔥 UI-only fields (NOT stored in Firestore)
  final String? otherUserName;
  final String? otherUserPhoto;

  ChatModel({
    required this.chatId,
    required this.lastMessage,
    required this.lastMessageSenderId,
    required this.lastMessageTime,
    required this.participants,
    this.otherUserName,
    this.otherUserPhoto,
  });

  /// 🔄 Firestore → ChatModel
  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatId: map['chatId'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      lastMessageSenderId: map['lastMessageSenderId'] ?? '',
      lastMessageTime: map['lastMessageTime'] != null
          ? (map['lastMessageTime'] as Timestamp).toDate()
          : DateTime.now(),
      participants: List<String>.from(map['participants'] ?? []),
    );
  }

  /// 🔄 ChatModel → Firestore
  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'lastMessage': lastMessage,
      'lastMessageSenderId': lastMessageSenderId,
      'lastMessageTime': Timestamp.fromDate(lastMessageTime),
      'participants': participants,
    };
  }

  /// 🧠 Safe immutable updates (used in HomeController)
  ChatModel copyWith({
    String? lastMessage,
    DateTime? lastMessageTime,
    String? otherUserName,
    String? otherUserPhoto,
  }) {
    return ChatModel(
      chatId: chatId,
      participants: participants,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageSenderId: lastMessageSenderId,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      otherUserName: otherUserName ?? this.otherUserName,
      otherUserPhoto: otherUserPhoto ?? this.otherUserPhoto,
    );
  }
}
