import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/message_model.dart';

class ChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String chatId;
  late String friendId;
  late String friendName;

  RxList<MessageModel> messages = <MessageModel>[].obs;
  RxBool isLoading = true.obs;

  final messageController = TextEditingController();


  // void onInit() {
  //   super.onInit();
  //
  //   chatId = Get.arguments['chatId'];
  //   friendId = Get.arguments['friendId'];
  //   friendName = Get.arguments['friendName'];
  //
  //   ensureChatExists(); // ✅ THIS IS THE KEY
  //   listenToMessages();
  // }

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;

    if (args == null ||
        args['chatId'] == null ||
        args['friendId'] == null) {
      Get.back();
      return;
    }

    chatId = args['chatId'];
    friendId = args['friendId'];
    friendName = args['friendName'] ?? 'User';

    ensureChatExists();
    listenToMessages();
  }


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

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final uid = _auth.currentUser!.uid;

    final messageRef = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc();

    await messageRef.set({
      'messageId': messageRef.id,
      'senderId': uid,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // 🔥 THIS MAKES CHAT APPEAR IN HOME
    await _firestore.collection('chats').doc(chatId).update({
      'lastMessage': text,
      'lastMessageSenderId': uid,
      'lastMessageTime':  DateTime.now(),
    });

    messageController.clear();
  }


  // <---------for chats i update here----->
  Future<void> ensureChatExists() async {
    final uid = _auth.currentUser!.uid;

    final chatRef = _firestore.collection('chats').doc(chatId);

    final doc = await chatRef.get();

    if (!doc.exists) {
      await chatRef.set({
        'chatId': chatId,
        'participants': [uid, friendId],
        'lastMessage': '',
        'lastMessageSenderId': '',
        'lastMessageTime': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

}
