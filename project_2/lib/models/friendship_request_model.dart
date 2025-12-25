import 'package:cloud_firestore/cloud_firestore.dart';

class FriendshipRequestModel {
  final String fromUserId;
  final String toUserId;
  final String status; // pending, accepted, rejected
  final Timestamp createdAt;

  FriendshipRequestModel({
    required this.fromUserId,
    required this.toUserId,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'status': status,
      'createdAt': createdAt,
    };
  }

  factory FriendshipRequestModel.fromMap(Map<String, dynamic> map) {
    return FriendshipRequestModel(
      fromUserId: map['fromUserId'],
      toUserId: map['toUserId'],
      status: map['status'],
      createdAt: map['createdAt'],
    );
  }
}
