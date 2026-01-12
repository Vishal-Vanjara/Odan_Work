import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/controllers/home_controller.dart';
import '../models/message_model.dart';
import '../services/notification_service.dart';

class ChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // navigation args
  late String chatId;
  late String friendId;
  late String friendName;

  // message state
  RxList<MessageModel> messages = <MessageModel>[].obs;
  RxBool isLoading = true.obs;

  // online status
  RxBool isFriendOnline = false.obs;
  Rx<DateTime?> lastSeen = Rx<DateTime?>(null);

  final TextEditingController messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if(args == null || args is! Map<String,dynamic>){
      // 🚨 prevents silent navigation failure
      Get.back();
      return;
    }


    chatId = args['chatId'];
    friendId = args['friendId'];
    friendName = args['friendName'];

    // ensureChatExists();
    listenToMessages();
    listenToFriendStatus();
  }

  // Future<void> createChatIfNotExists({
  //   required String chatId,
  //   required String friendId,
  // }) async {
  //   final uid = _auth.currentUser!.uid;
  //   final ref = _firestore.collection('chats').doc(chatId);
  //
  //   final doc = await ref.get();
  //   if (doc.exists) return;
  //
  //   await ref.set({
  //     'chatId': chatId,
  //     'participants': [uid, friendId],
  //     'lastMessage': '',
  //     'lastMessageSenderId': '',
  //     'lastMessageTime': FieldValue.serverTimestamp(), // 🔥 IMPORTANT
  //     'createdAt': FieldValue.serverTimestamp(),
  //   });
  // }


  /// ensure chat doc exists so it appears in Home
  // Future<void> ensureChatExists() async {
  //   final uid = _auth.currentUser!.uid;
  //   final ref = _firestore.collection('chats').doc(chatId);
  //
  //   final doc = await ref.get();
  //   if (!doc.exists) {
  //     await ref.set({
  //       'chatId': chatId,
  //       'participants': [uid, friendId],
  //       'lastMessage': '',
  //       'lastMessageSenderId': '',
  //       'lastMessageTime': DateTime.now(),
  //     });
  //   }
  // }

  /// listen to messages
  void listenToMessages() {
    _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      messages.value = snapshot.docs
          .map((e) => MessageModel.fromMap(e.data()))
          .toList();
      isLoading.value = false;
    });
  }

  /// send message
  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final uid = _auth.currentUser!.uid;

    final ref = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc();

    // 1️⃣ save message
    await ref.set({
      'messageId': ref.id,
      'senderId': uid,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // 2️⃣ update chat meta (for Home recent chat)
    await _firestore.collection('chats').doc(chatId).update({
      'lastMessage': text,
      'lastMessageSenderId': uid,
      // 'lastMessageTime': FieldValue.serverTimestamp(),
      'lastMessageTime': Timestamp.now(),
    });

    // 3️⃣ SEND NOTIFICATION 🔔 (🔥 THIS CREATES FIRESTORE STRUCTURE)
    final userInfo = await _getCurrentUserInfo();

    await NotificationService.sendNotification(
      receiverId: friendId,
      title: 'New message',
      body: text,
      senderName: userInfo['name']!,
      senderPhoto: userInfo['photo']!,
      type: 'message',
    );

    messageController.clear();

    /// this is key line to refresh chat in controller
    Get.find<HomeController>().refreshChats();
  }


  /// delete message (only yours)
  Future<void> deleteMessage(String messageId) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  /// edit message
  Future<void> editMessage(String messageId, String newText) async {
    if (newText.isEmpty) return;

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({
      'text': newText,
      'editedAt': FieldValue.serverTimestamp(),
    });
  }

  /// online / offline listener
  void listenToFriendStatus() {
    _firestore.collection('users').doc(friendId).snapshots().listen((doc) {
      final data = doc.data();
      if (data == null) return;

      isFriendOnline.value = data['isOnline'] ?? false;
      lastSeen.value = data['lastSeen'] != null
          ? (data['lastSeen'] as dynamic).toDate()
          : null;
    });
  }

  Future<Map<String, String>> _getCurrentUserInfo() async {
    final uid = _auth.currentUser!.uid;
    final doc = await _firestore.collection('users').doc(uid).get();

    return {
      'name': doc.data()?['displayName'] ?? 'User',
      'photo': doc.data()?['photoURL'] ?? '',
    };
  }

}
