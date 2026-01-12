import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static Future<void> createChatIfNotExists({
    required String chatId,
    required String friendId,
  }) async {
    final uid = _auth.currentUser!.uid;
    final ref = _firestore.collection('chats').doc(chatId);

    final doc = await ref.get();
    if (doc.exists) return;

    await ref.set({
      'chatId': chatId,
      'participants': [uid, friendId],
      'lastMessage': '',
      'lastMessageSenderId': '',
      // 'lastMessageTime': FieldValue.serverTimestamp(),
      // 'createdAt': FieldValue.serverTimestamp(),
      'lastMessageTime': Timestamp.now(),
      'createdAt': Timestamp.now(),
    });
  }
}
