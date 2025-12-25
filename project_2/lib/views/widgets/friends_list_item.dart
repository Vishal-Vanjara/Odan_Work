import 'package:flutter/material.dart';
import '../../../models/friends_model.dart';

class FriendsListItem extends StatelessWidget {
  final FriendModel friend;
  final VoidCallback onMessage;
  final VoidCallback onRemove;

  const FriendsListItem({
    super.key,
    required this.friend,
    required this.onMessage,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundImage: friend.photoURL.isNotEmpty
                  ? NetworkImage(friend.photoURL)
                  : null,
              child: friend.photoURL.isEmpty
                  ? const Icon(Icons.person)
                  : null,
            ),
            if (friend.isOnline)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Text(friend.displayName),
        subtitle: Text(friend.email),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'message') onMessage();
            if (value == 'remove') onRemove();
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 'message',
              child: Text("Message"),
            ),
            PopupMenuItem(
              value: 'remove',
              child: Text("Remove Friend"),
            ),
          ],
        ),
      ),
    );
  }
}
