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
        leading: CircleAvatar(
          child: Text(user.displayName[0].toUpperCase()),
        ),
        title: Text(user.displayName),
        subtitle: Text(user.email),
        trailing: FutureBuilder<bool>(
          future: controller.hasRequest(user.id),
          builder: (context, snapshot) {
            final hasRequest = snapshot.data ?? false;

            if (hasRequest) {
              return TextButton(
                onPressed: () => controller.cancelRequest(user.id),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            return ElevatedButton(
              onPressed: () => controller.sendRequest(user.id),
              child: const Text('Add Friend'),
            );
          },
        ),
      ),
    );
  }
}
