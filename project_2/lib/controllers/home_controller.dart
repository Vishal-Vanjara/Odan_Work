import 'dart:async';
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

  StreamSubscription? _chatSub;

  @override
  void onInit() {
    super.onInit();
    listenToChats();
  }

  void listenToChats() {
    final uid = _auth.currentUser!.uid;

    isLoading.value = true;
    _chatSub?.cancel();

    _chatSub = _firestore
        .collection('chats')
        .where('participants', arrayContains: uid)
        .snapshots()
        .listen((snapshot) async {
      final tempChats = <ChatModel>[];


      for (var doc in snapshot.docs) {
        final baseChat = ChatModel.fromMap(doc.data());

        final otherUserId =
        baseChat.participants.firstWhere((id) => id != uid);

        // fetch user profile
        final userDoc =
        await _firestore.collection('users').doc(otherUserId).get();

        final name = userDoc.data()?['displayName'] ?? 'User';
        final photo = userDoc.data()?['photoURL'] ?? '';

        // 🔥 fetch LAST message from messages collection
        final msgSnap = await _firestore
            .collection('chats')
            .doc(baseChat.chatId)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();

        if (msgSnap.docs.isNotEmpty) {
          final msg = msgSnap.docs.first.data();

          tempChats.add(
            baseChat.copyWith(
              otherUserName: name,
              otherUserPhoto: photo,
              lastMessage: msg['text'] ?? '',
              lastMessageTime:
              (msg['timestamp'] as Timestamp).toDate(),
            ),
          );
        } else {
          tempChats.add(
            baseChat.copyWith(
              otherUserName: name,
              otherUserPhoto: photo,
            ),
          );
        }
      }



      // for (var doc in snapshot.docs) {
      //   final chat = ChatModel.fromMap(doc.data());
      //
      //   // 🔹 find the other user
      //   final otherUserId =
      //   chat.participants.firstWhere((id) => id != uid);
      //
      //   // 🔹 fetch other user's profile
      //   final userDoc =
      //   await _firestore.collection('users').doc(otherUserId).get();
      //
      //   chat.otherUserName =
      //       userDoc.data()?['displayName'] ?? 'User';
      //   chat.otherUserPhoto =
      //       userDoc.data()?['photoURL'] ?? '';
      //
      //   // 🔥 FETCH LATEST MESSAGE (THIS FIXES YOUR BUG)
      //   final msgSnap = await _firestore
      //       .collection('chats')
      //       .doc(chat.chatId)
      //       .collection('messages')
      //       .orderBy('timestamp', descending: true)
      //       .limit(1)
      //       .get();
      //
      //   if (msgSnap.docs.isNotEmpty) {
      //     final msg = msgSnap.docs.first.data();
      //     // chat.lastMessage = msg['text'] ?? '';
      //     // chat.lastMessageTime =
      //     //     (msg['timestamp'] as Timestamp?)?.toDate();
      //     final updatedChat = chat.copyWith(
      //       lastMessage: msg['text'] ?? '',
      //       lastMessageTime:
      //       (msg['timestamp'] as Timestamp?)?.toDate(),
      //     );
      //
      //     tempChats.add(updatedChat);
      //     continue;
      //
      //   } else {
      //     chat.lastMessage = '';
      //     chat.lastMessageTime = null;
      //   }
      //
      //   tempChats.add(chat);
      // }

      // 🔥 SORT LOCALLY BY REAL LAST MESSAGE TIME
      tempChats.sort(
            (a, b) => (b.lastMessageTime ?? DateTime(0))
            .compareTo(a.lastMessageTime ?? DateTime(0)),
      );

      chats.value = tempChats;
      isLoading.value = false;
    });
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  @override
  void onClose() {
    _chatSub?.cancel();
    super.onClose();
  }
  void refreshChats() {
    listenToChats();
  }

}
