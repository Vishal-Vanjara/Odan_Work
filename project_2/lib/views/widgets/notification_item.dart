import 'package:flutter/material.dart';
import '../../models/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: notification.isRead
          ? Colors.transparent
          : Colors.blue.withOpacity(0.05),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: notification.senderPhoto.isNotEmpty
              ? NetworkImage(notification.senderPhoto)
              : null,
          child: notification.senderPhoto.isEmpty
              ? const Icon(Icons.person)
              : null,
        ),
        title: Text(
          notification.senderName,
          style: TextStyle(
            fontWeight:
            notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Text(notification.body),
        trailing: Text(
          _timeAgo(notification.createdAt),
          style: const TextStyle(fontSize: 12),
        ),
        onTap: onTap,
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hrs ago';
    } else {
      return '${diff.inDays} days ago';
    }
  }
}
