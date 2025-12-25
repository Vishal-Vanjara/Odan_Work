import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/users_model.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get currentUserId => _auth.currentUser!.uid;

  /// 🔹 Get all users except current user
  Stream<List<UserModel>> getAllUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .where((user) => user.id != currentUserId)
          .toList();
    });
  }

  /// 🔹 Send friend request
  Future<void> sendFriendRequest(String toUserId) async {
    await _firestore.collection('friend_requests').add({
      'fromUserId': currentUserId,
      'toUserId': toUserId,
      'status': 'pending',
      'createdAt': Timestamp.now(),
    });
  }

  /// 🔹 Cancel friend request
  Future<void> cancelFriendRequest(String toUserId) async {
    final query = await _firestore
        .collection('friend_requests')
        .where('fromUserId', isEqualTo: currentUserId)
        .where('toUserId', isEqualTo: toUserId)
        .get();

    for (var doc in query.docs) {
      await doc.reference.delete();
    }
  }

  /// 🔹 Check request status
  Future<bool> hasPendingRequest(String toUserId) async {
    final query = await _firestore
        .collection('friend_requests')
        .where('fromUserId', isEqualTo: currentUserId)
        .where('toUserId', isEqualTo: toUserId)
        .where('status', isEqualTo: 'pending')
        .get();

    return query.docs.isNotEmpty;
  }
}
