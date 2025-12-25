import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/chat_model.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;
  RxString searchQuery = ''.obs;

  RxList<ChatModel> chats = <ChatModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    listenToChats();
  }

  void listenToChats() {
    final uid = _auth.currentUser!.uid;

    isLoading.value = true;

    _firestore
        .collection('chats')
        .where('participants', arrayContains: uid)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .listen((snapshot) async {
      final tempChats = <ChatModel>[];

      for (var doc in snapshot.docs) {
        final chat = ChatModel.fromMap(doc.data());

        // 🔥 find other user
        final otherUserId =
        chat.participants.firstWhere((id) => id != uid);

        // 🔥 fetch user profile
        final userDoc =
        await _firestore.collection('users').doc(otherUserId).get();

        chat.otherUserName = userDoc.data()?['displayName'] ?? 'User';
        chat.otherUserPhoto = userDoc.data()?['photoURL'] ?? '';



        tempChats.add(chat);
      }

      chats.value = tempChats;
      isLoading.value = false;
    });
  }



  void updateSearch(String value) {
    searchQuery.value = value;
  }
}
