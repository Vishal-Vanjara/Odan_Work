import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/friend_request_controller.dart';
import '../widgets/friend_request_item.dart';

class FriendRequestView extends StatelessWidget {
  const FriendRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FriendRequestController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Friend Requests"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          /// 🔁 TABS
          Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _tabButton(
                  icon: Icons.inbox,
                  text:
                  "Received (${controller.receivedRequests.length})",
                  selected: controller.selectedTab.value ==
                      FriendRequestTab.received,
                  onTap: () => controller
                      .switchTab(FriendRequestTab.received),
                ),
                const SizedBox(width: 12),
                _tabButton(
                  icon: Icons.send,
                  text: "Sent (${controller.sentRequests.length})",
                  selected: controller.selectedTab.value ==
                      FriendRequestTab.sent,
                  onTap: () =>
                      controller.switchTab(FriendRequestTab.sent),
                ),
              ],
            ),
          )),

          const SizedBox(height: 12),

          /// 📋 LIST
          Expanded(
            child: Obx(() {
              final isReceived =
                  controller.selectedTab.value ==
                      FriendRequestTab.received;

              final list = isReceived
                  ? controller.receivedRequests
                  : controller.sentRequests;

              if (list.isEmpty) {
                return const Center(child: Text("No requests"));
              }

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return FriendRequestItem(
                    friend: list[index],
                    showActions: isReceived, // 👈 important
                    onAccept: () =>
                        controller.acceptRequest(list[index]),
                    onReject: () =>
                        controller.rejectRequest(list[index]),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _tabButton({
    required IconData icon,
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? Colors.blue : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 18,
                  color: selected ? Colors.white : Colors.black54),
              const SizedBox(width: 6),
              Text(
                text,
                style: TextStyle(
                  color:
                  selected ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
