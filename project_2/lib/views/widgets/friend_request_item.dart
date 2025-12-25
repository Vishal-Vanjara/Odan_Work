import 'package:flutter/material.dart';
import '../../../models/friends_model.dart';

class FriendRequestItem extends StatelessWidget {
  final FriendModel friend;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final bool showActions; // 👈 NEW

  const FriendRequestItem({
    super.key,
    required this.friend,
    this.onAccept,
    this.onReject,
    this.showActions = true, // default = received tab
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: friend.photoURL.isNotEmpty
                    ? NetworkImage(friend.photoURL)
                    : null,
                child: friend.photoURL.isEmpty
                    ? const Icon(Icons.person)
                    : null,
              ),
              title: Text(friend.displayName),
              subtitle: Text(friend.email),
            ),

            /// 👇 Buttons only for RECEIVED tab
            if (showActions) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onReject,
                      child: const Text("Decline"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onAccept,
                      child: const Text("Accept"),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
