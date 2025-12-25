import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/routes/app_routes.dart';
import 'package:project_2/views/widgets/friends_list_item.dart';
import '../../controllers/friends_controller.dart';

String generateChatId(String uid1, String uid2) {
  return uid1.compareTo(uid2) < 0
      ? '${uid1}_$uid2'
      : '${uid2}_$uid1';
}


class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    // final FriendsController controller = Get.put(FriendsController());
    final FriendsController controller = Get.find<FriendsController>();


    return Scaffold(
      appBar: AppBar(
        title: const Text("Friends"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt),
            onPressed: () => Get.toNamed(AppRoutes.friendRequest),
          ),
        ],
      ),
      body: Column(
        children: [
          /// 🔍 Search Friends (logic later)
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Friends",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          /// 🧑‍🤝‍🧑 Friends list
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.friends.isEmpty) {
                return const Center(child: Text("No friends yet"));
              }

              return ListView.builder(
                itemCount: controller.friends.length,
                itemBuilder: (context, index) {
                  return FriendsListItem(
                    friend: controller.friends[index],
                    onMessage: () {
                      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
                      final friend = controller.friends[index];

                      final chatId = generateChatId(currentUserId, friend.friendId);

                      Get.toNamed(
                        AppRoutes.chat,
                        arguments: {
                          'chatId': chatId,
                          'friendId': friend.friendId,
                          'friendName': friend.displayName,
                        },
                      );
                    },

                    onRemove: () => controller
                        .removeFriend(controller.friends[index].friendId),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
