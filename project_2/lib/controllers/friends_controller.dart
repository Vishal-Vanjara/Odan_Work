import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/friends_model.dart';

class FriendsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;
  RxList<FriendModel> friends = <FriendModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    listenToFriends();
  }

  /// 🔥 Listen to accepted friends
  void listenToFriends() {
    final userId = _auth.currentUser!.uid;
    isLoading.value = true;

    _firestore
        .collection('friends')
        .doc(userId)
        .collection('list')
        .orderBy('addedAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      friends.value = snapshot.docs
          .map((doc) => FriendModel.fromMap(doc.data()))
          .toList();

      isLoading.value = false;
    });
  }

  /// ❌ Remove friend (bi-directional)
  Future<void> removeFriend(String friendId) async {
    // final userId = _auth.currentUser!.uid;

    final user = _auth.currentUser;
    if (user == null) {
      isLoading.value = false;
      return;
    }
    final userId = user.uid;


    await _firestore
        .collection('friends')
        .doc(userId)
        .collection('list')
        .doc(friendId)
        .delete();

    await _firestore
        .collection('friends')
        .doc(friendId)
        .collection('list')
        .doc(userId)
        .delete();
  }
}
