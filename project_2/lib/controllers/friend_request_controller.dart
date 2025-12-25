import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/friends_model.dart';

enum FriendRequestTab {
  received,
  sent,
}


class FriendRequestController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;

  Rx<FriendRequestTab> selectedTab =
      FriendRequestTab.received.obs;

  RxList<FriendModel> receivedRequests = <FriendModel>[].obs;
  RxList<FriendModel> sentRequests = <FriendModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    listenToReceivedRequests();
    listenToSentRequests();
  }

  void switchTab(FriendRequestTab tab) {
    selectedTab.value = tab;
  }

  /// 📥 RECEIVED requests
  void listenToReceivedRequests() {
    final uid = _auth.currentUser!.uid;

    _firestore
        .collection('friend_requests')
        .where('toUserId', isEqualTo: uid)
        .snapshots()
        .listen((snapshot) async {
      List<FriendModel> list = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final userDoc = await _firestore
            .collection('users')
            .doc(data['fromUserId'])
            .get();

        if (!userDoc.exists) continue;

        final u = userDoc.data()!;
        list.add(_mapUserToFriend(u));
      }

      receivedRequests.value = list;
    });
  }

  /// 📤 SENT requests
  void listenToSentRequests() {
    final uid = _auth.currentUser!.uid;

    _firestore
        .collection('friend_requests')
        .where('fromUserId', isEqualTo: uid)
        .snapshots()
        .listen((snapshot) async {
      List<FriendModel> list = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final userDoc = await _firestore
            .collection('users')
            .doc(data['toUserId'])
            .get();

        if (!userDoc.exists) continue;

        final u = userDoc.data()!;
        list.add(_mapUserToFriend(u));
      }

      sentRequests.value = list;
    });
  }

  FriendModel _mapUserToFriend(Map<String, dynamic> u) {
    return FriendModel(
      friendId: u['id'],
      displayName: u['displayName'],
      email: u['email'],
      photoURL: u['photoURL'] ?? '',
      isOnline: u['isOnline'] ?? false,
      lastSeen: (u['lastSeen'] as Timestamp).toDate(),
      addedAt: DateTime.now(),
    );
  }

  /// ✅ Accept friend request
  Future<void> acceptRequest(FriendModel friend) async {
    final currentUser = _auth.currentUser!;
    final batch = _firestore.batch();

    // Current user data
    final currentUserDoc =
    await _firestore.collection('users').doc(currentUser.uid).get();
    final currentUserData = currentUserDoc.data()!;

    // Add friend for current user
    batch.set(
      _firestore
          .collection('friends')
          .doc(currentUser.uid)
          .collection('list')
          .doc(friend.friendId),
      friend.toMap(),
    );

    // Add current user as friend for sender
    batch.set(
      _firestore
          .collection('friends')
          .doc(friend.friendId)
          .collection('list')
          .doc(currentUser.uid),
      {
        'friendId': currentUser.uid,
        'displayName': currentUserData['displayName'],
        'email': currentUserData['email'],
        'photoURL': currentUserData['photoURL'],
        'isOnline': currentUserData['isOnline'],
        'lastSeen': currentUserData['lastSeen'],
        'addedAt': FieldValue.serverTimestamp(),
      },
    );

    // Remove friend request
    final requestQuery = await _firestore
        .collection('friend_requests')
        .where('fromUserId', isEqualTo: friend.friendId)
        .where('toUserId', isEqualTo: currentUser.uid)
        .get();

    for (var doc in requestQuery.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();

    Get.snackbar(
      "Success",
      "Friend request accepted",
      snackPosition: SnackPosition.TOP,
    );
  }

  /// ❌ Reject friend request
  Future<void> rejectRequest(FriendModel friend) async {
    final uid = _auth.currentUser!.uid;

    final requestQuery = await _firestore
        .collection('friend_requests')
        .where('fromUserId', isEqualTo: friend.friendId)
        .where('toUserId', isEqualTo: uid)
        .get();

    for (var doc in requestQuery.docs) {
      await doc.reference.delete();
    }

    Get.snackbar(
      "Rejected",
      "Friend request declined",
      snackPosition: SnackPosition.TOP,
    );
  }

}












// class FriendRequestController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   RxBool isLoading = false.obs;
//   RxList<FriendModel> receivedRequests = <FriendModel>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     listenToReceivedRequests();
//   }
//
//   /// 🔥 Listen to RECEIVED friend requests
//   void listenToReceivedRequests() {
//     final currentUserId = _auth.currentUser!.uid;
//     isLoading.value = true;
//
//     _firestore
//         .collection('friend_requests')
//         .where('toUserId', isEqualTo: currentUserId)
//         .snapshots()
//         .listen((snapshot) async {
//       List<FriendModel> tempList = [];
//
//       for (var doc in snapshot.docs) {
//         final requestData = doc.data();
//
//         final userDoc = await _firestore
//             .collection('users')
//             .doc(requestData['fromUserId'])
//             .get();
//
//         if (!userDoc.exists) continue;
//
//         final userData = userDoc.data()!;
//
//         tempList.add(
//           FriendModel(
//             friendId: userData['id'],
//             displayName: userData['displayName'],
//             email: userData['email'],
//             photoURL: userData['photoURL'] ?? '',
//             isOnline: userData['isOnline'] ?? false,
//             lastSeen: (userData['lastSeen'] as Timestamp).toDate(),
//             addedAt: DateTime.now(),
//           ),
//         );
//       }
//
//       receivedRequests.value = tempList;
//       isLoading.value = false;
//     });
//   }
//
//   /// ✅ Accept friend request
//   Future<void> acceptRequest(FriendModel friend) async {
//     final currentUser = _auth.currentUser!;
//     final batch = _firestore.batch();
//
//     final currentUserDoc =
//     await _firestore.collection('users').doc(currentUser.uid).get();
//
//     final currentUserData = currentUserDoc.data()!;
//
//     // Add friend for current user
//     batch.set(
//       _firestore
//           .collection('friends')
//           .doc(currentUser.uid)
//           .collection('list')
//           .doc(friend.friendId),
//       friend.toMap(),
//     );
//
//     // Add current user as friend for sender
//     batch.set(
//       _firestore
//           .collection('friends')
//           .doc(friend.friendId)
//           .collection('list')
//           .doc(currentUser.uid),
//       {
//         'friendId': currentUser.uid,
//         'displayName': currentUserData['displayName'],
//         'email': currentUserData['email'],
//         'photoURL': currentUserData['photoURL'],
//         'isOnline': currentUserData['isOnline'],
//         'lastSeen': currentUserData['lastSeen'],
//         'addedAt': FieldValue.serverTimestamp(),
//       },
//     );
//
//     // Remove friend request
//     final requestQuery = await _firestore
//         .collection('friend_requests')
//         .where('fromUserId', isEqualTo: friend.friendId)
//         .where('toUserId', isEqualTo: currentUser.uid)
//         .get();
//
//     for (var doc in requestQuery.docs) {
//       batch.delete(doc.reference);
//     }
//
//     await batch.commit();
//   }
//
//   /// ❌ Reject friend request
//   Future<void> rejectRequest(FriendModel friend) async {
//     final requestQuery = await _firestore
//         .collection('friend_requests')
//         .where('fromUserId', isEqualTo: friend.friendId)
//         .where('toUserId', isEqualTo: _auth.currentUser!.uid)
//         .get();
//
//     for (var doc in requestQuery.docs) {
//       await doc.reference.delete();
//     }
//   }
// }
