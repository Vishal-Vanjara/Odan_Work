import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_list_controller.dart';
import '../widgets/user_list_item.dart';

class FindPeopleView extends GetView<UserListController> {
  const FindPeopleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find People'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search people',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => controller.searchQuery.value = value,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.filteredUsers.isEmpty) {
                  return const Center(child: Text('No users found'));
                }

                return ListView.builder(
                  itemCount: controller.filteredUsers.length,
                  itemBuilder: (context, index) {
                    return UserListItem(
                      user: controller.filteredUsers[index],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
