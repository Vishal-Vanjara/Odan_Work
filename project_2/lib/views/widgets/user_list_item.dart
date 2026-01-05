import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_list_controller.dart';
import '../../models/users_model.dart';

class UserListItem extends StatelessWidget {
  final UserModel user;

  const UserListItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserListController>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(child: Text(user.displayName[0].toUpperCase())),
        title: Text(user.displayName),
        subtitle: Text(user.email),

        /// 🔥 Reactive button
        /// <------------------This is without animation at button --------------------------->
        // trailing: Obx(() {
        //   final isFriend = controller.friendUserIds.contains(user.id);
        //
        //   final hasSentRequest = controller.sentRequestUserIds.contains(
        //     user.id,
        //   );
        //
        //   if (isFriend) {
        //     return ElevatedButton(
        //       onPressed: null,
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: Colors.grey.shade400,
        //       ),
        //       child: const Text('Friends'),
        //     );
        //   }
        //
        //   if (hasSentRequest) {
        //     return TextButton(
        //       onPressed: () => controller.cancelRequest(user.id),
        //       child: const Text(
        //         'Request Sent',
        //         style: TextStyle(color: Colors.grey),
        //       ),
        //     );
        //   }
        //
        //   return ElevatedButton(
        //     onPressed: () => controller.sendRequest(user.id),
        //     child: const Text('Add Friend'),
        //   );
        // }),

        ///<---------------- This one with animation in button -------------------------->
        trailing: Obx(() {
          final isFriend =
          controller.friendUserIds.contains(user.id);
          final hasSentRequest =
          controller.sentRequestUserIds.contains(user.id);

          Widget button;

          if (isFriend) {
            button = ElevatedButton(
              key: const ValueKey('friends'),
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade400,
              ),
              child: const Text('Friends'),
            );
          } else if (hasSentRequest) {
            button = TextButton(
              key: const ValueKey('sent'),
              onPressed: () => controller.cancelRequest(user.id),
              child: const Text('Request Sent'),
            );
          } else {
            button = ElevatedButton(
              key: const ValueKey('add'),
              onPressed: () => controller.sendRequest(user.id),
              child: const Text('Add Friend'),
            );
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.95, end: 1.0)
                      .animate(animation),
                  child: child,
                ),
              );
            },
            child: button,
          );
        }),

      ),
    );
  }
}
