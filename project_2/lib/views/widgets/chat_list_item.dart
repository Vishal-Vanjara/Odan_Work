import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/chat_model.dart';

class ChatListItem extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback onTap;

  const ChatListItem({
    super.key,
    required this.chat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final unreadCount = chat.unreadCounts[uid] ?? 0;

    return ListTile(
      onTap: onTap,
      title: Text(chat.otherUserName ?? 'User'),

      subtitle: Text(
        chat.lastMessage.isNotEmpty
            ? chat.lastMessage
            : 'Start a conversation',
        maxLines: 1,
        overflow:  TextOverflow.ellipsis,
      ),
      leading: CircleAvatar(
        backgroundImage: chat.otherUserPhoto != null &&
            chat.otherUserPhoto!.isNotEmpty
            ? NetworkImage(chat.otherUserPhoto!)
            : null,
        child: chat.otherUserPhoto == null
            ? const Icon(Icons.person)
            : null,
      ),

      trailing: unreadCount > 0 ? Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: Color(0xFF40C0B5),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            unreadCount.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ) : null,

    );
  }
}
