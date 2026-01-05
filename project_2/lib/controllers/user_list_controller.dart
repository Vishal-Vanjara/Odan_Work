import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/users_model.dart';
import '../services/firebase_services.dart';

class UserListController extends GetxController {
  final FirebaseServices _firebaseServices = FirebaseServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxList<UserModel> users = <UserModel>[].obs;
  final RxString searchQuery = ''.obs;

  final RxSet<String> sentRequestUserIds = <String>{}.obs;
  final RxSet<String> friendUserIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUsers();
    _listenToSentRequests();
    _listenToFriends();
  }

  void _loadUsers() {
    _firebaseServices.getAllUsers().listen((userList) {
      users.value = userList;
    });
  }

  void _listenToSentRequests() {
    final uid = _auth.currentUser!.uid;

    _firestore
        .collection('friend_requests')
        .where('fromUserId', isEqualTo: uid)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .listen((snapshot) {
          sentRequestUserIds.value = snapshot.docs
              .map((d) => d['toUserId'] as String)
              .toSet();
        });
  }

  void _listenToFriends() {
    final uid = _auth.currentUser!.uid;
    _firestore
        .collection('friends')
        .doc(uid)
        .collection('list')
        .snapshots()
        .listen((snapshot) {
          friendUserIds.value = snapshot.docs.map((doc) => doc.id).toSet();
        });
  }

  List<UserModel> get filteredUsers {
    if (searchQuery.value.isEmpty) return users;
    return users.where((user) {
      return user.displayName.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ||
          user.email.toLowerCase().contains(searchQuery.value.toLowerCase());
    }).toList();
  }

  Future<void> sendRequest(String userId) async {
    await _firebaseServices.sendFriendRequest(userId);
  }

  Future<void> cancelRequest(String userId) async {
    await _firebaseServices.cancelFriendRequest(userId);
  }
}
