import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          Obx(
            () => TextButton(
              onPressed: () {
                controller.isEditing.toggle();
              },
              child: Text(
                controller.isEditing.value ? 'Cancel' : 'Edit',
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ),
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
                      // onTap: controller.signOut,
                      onTap: _signOutAccountDialog,
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
            const Text(
              'Personal Information',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: controller.updateDisplayName,
                    child: const Text('Save'),
                  ),
                ),
              ),
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

  /// Change Password Dialog
  void _changePasswordDialog() {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text("Change Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: oldPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Old Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (newPasswordController.text != confirmPasswordController) {
                Get.snackbar('Error', 'Password do not match');
                return;
              }
              Get.find<AuthController>().changePassword(
                oldPassword: oldPasswordController.text.trim(),
                newPassword: newPasswordController.text.trim(),
              );
              Get.back();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  /// 🗑 Delete Account Dialog
  void _deleteAccountDialog() {
    final passwordController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Delete Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Please enter your password to confirm account deletion.',
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Get.find<AuthController>().deleteAccount(
                password: passwordController.text.trim(),
              );
              Get.back();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }


  /// 🗑 SignOut Account Dialog
  void _signOutAccountDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('SignOut Account'),
        content: const Text('Are you sure you want to Sign out this account?'),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade400,
            ),
            onPressed: controller.signOut,
            child: const Text('SignOut'),
          ),
        ],
      ),
    );
  }
}
