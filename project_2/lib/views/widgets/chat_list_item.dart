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
    return ListTile(
      onTap: onTap,
      title: Text(chat.otherUserName ?? 'User'),
      // subtitle: Text(
      //   chat.lastMessage,
      //   maxLines: 1,
      //   overflow: TextOverflow.ellipsis,
      // ),
      subtitle: Text(
        chat.lastMessage.isNotEmpty
            ? chat.lastMessage
            : 'Start a conversation',
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


      // title: Text(
      //   chat.lastMessage,
      //   maxLines: 1,
      //   overflow: TextOverflow.ellipsis,
      // ),
      // subtitle: Text(
      //   chat.lastMessageTime.toLocal().toString(),
      //   style: const TextStyle(fontSize: 12),
      // ),
      // leading: const CircleAvatar(
      //   radius: 24,
      //   child: Icon(Icons.person),
      // ),
    );
  }
}
