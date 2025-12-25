import 'package:cloud_firestore/cloud_firestore.dart';

class FriendModel {
  final String friendId;        // other user's uid
  final String displayName;
  final String email;
  final String photoURL;
  final bool isOnline;
  final DateTime lastSeen;
  final DateTime addedAt;

  FriendModel({
    required this.friendId,
    required this.displayName,
    required this.email,
    required this.photoURL,
    required this.isOnline,
    required this.lastSeen,
    required this.addedAt,
  });

  /// Firestore → FriendModel
  factory FriendModel.fromMap(Map<String, dynamic> map) {
    return FriendModel(
      friendId: map['friendId'],
      displayName: map['displayName'],
      email: map['email'],
      photoURL: map['photoURL'] ?? '',
      isOnline: map['isOnline'] ?? false,
      lastSeen: (map['lastSeen'] as Timestamp).toDate(),
      addedAt: (map['addedAt'] as Timestamp).toDate(),
    );
  }

  /// FriendModel → Firestore
  Map<String, dynamic> toMap() {
    return {
      'friendId': friendId,
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
      'isOnline': isOnline,
      'lastSeen': Timestamp.fromDate(lastSeen),
      'addedAt': Timestamp.fromDate(addedAt),
    };
  }
}
