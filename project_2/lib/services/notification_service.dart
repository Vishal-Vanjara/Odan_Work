import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  /// send notification to a user
  static Future<void> sendNotification({
    required String receiverId,
    required String title,
    required String body,
    required String senderName,
    required String senderPhoto,
    required String type, // message, friend, like, comment
  }) async {
    final ref = _firestore
        .collection('notifications')
        .doc(receiverId)
        .collection('items')
        .doc();

    await ref.set({
      'id': ref.id,
      'title': title,
      'body': body,
      'senderName': senderName,
      'senderPhoto': senderPhoto,
      'type': type,
      'isRead': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
