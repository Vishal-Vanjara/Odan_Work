import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          Obx(() => TextButton(
            onPressed: () {
              controller.isEditing.toggle();
            },
            child: Text(
              controller.isEditing.value ? 'Cancel' : 'Edit',
              style: const TextStyle(color: Colors.blue),
            ),
          ))
        ],
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _profileHeader(),
              const SizedBox(height: 24),
              _personalInfo(),
              const SizedBox(height: 20),
              _actionTile(
                title: 'Change Password',
                icon: Icons.lock,
                onTap: _changePasswordDialog,
              ),
              _actionTile(
                title: 'Delete Account',
                icon: Icons.delete,
                color: Colors.red,
                onTap: _deleteAccountDialog,
              ),
              _actionTile(
                title: 'Sign Out',
                icon: Icons.logout,
                onTap: controller.signOut,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _profileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text(
            controller.displayName.value.isNotEmpty
                ? controller.displayName.value[0].toUpperCase()
                : 'U',
            style: const TextStyle(fontSize: 32),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          controller.displayName.value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(controller.email.value),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.circle,
              size: 10,
              color: controller.isOnline.value ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 6),
            Text(controller.isOnline.value ? 'Online' : 'Offline'),
          ],
        ),
        if (controller.joinedAt.value != null)
          Text(
            'Joined ${controller.joinedAt.value!.year}',
            style: const TextStyle(color: Colors.grey),
          ),
      ],
    );
  }

  Widget _personalInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Personal Information',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: controller.displayNameController,
              enabled: controller.isEditing.value,
              decoration: const InputDecoration(labelText: 'Display Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: controller.email.value,
              ),
            ),
            if (controller.isEditing.value)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: controller.updateDisplayName,
                  child: const Text('Save'),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _actionTile({
    required String title,
    required IconData icon,
    Color? color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  /// 🔐 Change Password Dialog
  void _changePasswordDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Change Password'),
        content: TextField(
          controller: controller.passwordController,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'New Password'),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            onPressed: controller.changePassword,
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  /// 🗑 Delete Account Dialog
  void _deleteAccountDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Account'),
        content: const Text('Are you sure you want to delete this account?'),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: controller.deleteAccount,
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
