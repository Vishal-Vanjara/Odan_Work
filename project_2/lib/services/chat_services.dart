import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  ///Creates chat document only once , Prevents duplicate chats
  static Future<void> createChatIfNotExists({
    required String chatId,
    required String friendId,
  }) async {
    final uid = _auth.currentUser!.uid;
    final ref = _firestore.collection('chats').doc(chatId);

    /// if chat is already exits -> do nothing
    final doc = await ref.get();
    if (doc.exists) return;

    /// Creates a new chat Documents
    await ref.set({
      'chatId': chatId,
      'participants': [uid, friendId],
      'lastMessage': '',
      'lastMessageSenderId': '',
      // 'lastMessageTime': FieldValue.serverTimestamp(),
      // 'createdAt': FieldValue.serverTimestamp(),
      'lastMessageTime': Timestamp.now(),
      'createdAt': Timestamp.now(),

      /// unread count per user
      'unreadcounts' : {
        uid: 0,
        friendId : 0,
      }
    });
  }
}
