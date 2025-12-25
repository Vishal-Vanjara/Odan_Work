import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/main_controller.dart';
import '../../routes/app_routes.dart';
import '../widgets/chat_list_item.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: const [
          Icon(Icons.notifications_none),
          SizedBox(width: 12),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Redirect to Find Friends tab
          Get.find<MainController>().changeTab(2);
        },
        icon: const Icon(Icons.chat),
        label: const Text('New Chat'),
      ),

      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: controller.updateSearch,
              decoration: InputDecoration(
                hintText: 'Search conversations...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Filter Chips (UI only)
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                _FilterChip(label: 'All', selected: true),
                _FilterChip(label: 'Unread'),
                _FilterChip(label: 'Recent'),
                _FilterChip(label: 'Active'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Chat List / Empty State
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.chats.isEmpty) {
                return _EmptyState();
              }

              return ListView.builder(
                itemCount: controller.chats.length,
                itemBuilder: (context, index) {
                  final chat = controller.chats[index];
                  return ChatListItem(
                    chat: chat,
                      onTap: () {
                        final uid = FirebaseAuth.instance.currentUser!.uid;

                        // 🔥 Find the OTHER user
                        final otherUserId = chat.participants.firstWhere(
                              (id) => id != uid,
                        );

                        Get.toNamed(
                          AppRoutes.chat,
                          arguments: {
                            'chatId': chat.chatId,
                            'friendId': otherUserId,
                            'friendName': chat.otherUserName ?? 'User',
                            // we’ll fix this next
                          },
                        );
                      }

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

/// ---------------- EMPTY STATE ----------------

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.chat_bubble_outline, size: 80),
            const SizedBox(height: 16),
            const Text(
              'No conversations yet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Connect with friends and start meaningful conversations',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: () {
                Get.find<MainController>().changeTab(2);
              },
              icon: const Icon(Icons.person_add),
              label: const Text('Find People'),
            ),

            TextButton(
              onPressed: () {
                Get.find<MainController>().changeTab(1);
              },
              child: const Text('View Friends'),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------- FILTER CHIP ----------------

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _FilterChip({
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) {},
      ),
    );
  }
}
