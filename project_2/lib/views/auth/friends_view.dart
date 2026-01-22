import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/controllers/chat_controller.dart';
import 'package:project_2/routes/app_routes.dart';
import 'package:project_2/views/widgets/friends_list_item.dart';
import '../../controllers/friend_request_controller.dart';
import '../../controllers/friends_controller.dart';
import '../../services/chat_services.dart';

String generateChatId(String uid1, String uid2) {
  return uid1.compareTo(uid2) < 0 ? '${uid1}_$uid2' : '${uid2}_$uid1';
}

class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    // final FriendsController controller = Get.put(FriendsController());
    final FriendsController controller = Get.find<FriendsController>();

    ///<-------------------This for a count on new request---------------->
    final friendRequestController = Get.find<FriendRequestController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Friends"),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Icons.person_add_alt_1),
                onPressed: () {
                  Get.toNamed(AppRoutes.friendRequest);
                },
              ),

              /// 🔴 Friend request badge
              Obx(() {
                final count = friendRequestController.receivedRequests.length;

                if (count == 0) return const SizedBox();

                return Positioned(
                  right: 6,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      count > 9 ? '9+' : count.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ],
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
                    onMessage: () async {
                      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
                      final friend = controller.friends[index];

                      final chatId =
                      generateChatId(currentUserId, friend.friendId);

                      // ✅ Ensure chat exists BEFORE navigation
                      await ChatService.createChatIfNotExists(
                        chatId: chatId,
                        friendId: friend.friendId,
                      );

                      // ✅ Navigate AFTER creation
                      Get.toNamed(
                        AppRoutes.chat,
                        arguments: {
                          'chatId': chatId,
                          'friendId': friend.friendId,
                          'friendName': friend.displayName,
                        },
                      );
                    },
                    onRemove: () => controller.removeFriend(
                      controller.friends[index].friendId,
                    ),
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
