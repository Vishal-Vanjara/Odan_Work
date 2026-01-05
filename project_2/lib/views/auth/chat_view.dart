import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../controllers/chat_controller.dart';
import '../../models/message_model.dart';
import '../widgets/message_bubble.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.friendName),
              Text(
                controller.isFriendOnline.value
                    ? 'Online'
                    : controller.lastSeen.value != null
                    ? 'Last seen ${controller.lastSeen.value}'
                    : 'Offline',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.messages.isEmpty) {
                return const _EmptyChatState();
              }

              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(16),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];
                  final isMe = msg.senderId == uid;


                  // gor bubble messsage
                  return MessageBubble(
                    message: msg,
                    isMe: isMe,
                    onLongPress: isMe
                        ? () => _showOptions(context, msg)
                        : null,
                  );


                  // return GestureDetector(
                  //   onLongPress: isMe
                  //       ? () => _showOptions(context, msg)
                  //       : null,
                  //   child: Align(
                  //     alignment:
                  //     isMe ? Alignment.centerRight : Alignment.centerLeft,
                  //     child: Container(
                  //       margin: const EdgeInsets.only(bottom: 8),
                  //       padding: const EdgeInsets.all(12),
                  //       decoration: BoxDecoration(
                  //         color: isMe
                  //             ? const Color(0xFF27B0A5)
                  //             : Colors.grey.shade200,
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //       child: Text(
                  //         msg.text,
                  //         style: TextStyle(
                  //           color: isMe ? Colors.white : Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
              );
            }),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    mini: true,
                    onPressed: controller.sendMessage,
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOptions(BuildContext context, MessageModel msg) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              _editMessage(context, msg);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              Navigator.pop(context);
              controller.deleteMessage(msg.messageId);
            },
          ),
        ],
      ),
    );
  }

  void _editMessage(BuildContext context, MessageModel msg) {
    final textController = TextEditingController(text: msg.text);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit message'),
        content: TextField(controller: textController),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.editMessage(
                msg.messageId,
                textController.text.trim(),
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class _EmptyChatState extends StatelessWidget {
  const _EmptyChatState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.chat_bubble_outline, size: 80),
          SizedBox(height: 16),
          Text(
            'Start the conversation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text('Send a message to get the chat started'),
        ],
      ),
    );
  }
}
