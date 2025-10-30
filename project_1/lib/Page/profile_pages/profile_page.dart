import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_1/Page/profile_pages/my_address_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;

  //<----------------- Function to pick image
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildUserInfoSection(),
            const SizedBox(height: 32.0),
            _buildMenuItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
            child: _profileImage == null
                ? Icon(
              Icons.camera_alt,
              size: 40,
              color: Colors.grey[600],
            )
                : null,
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Luffy',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Text(
          'luffy@onepeice.com',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildMenuItems() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(Icons.home_outlined, 'My Address', () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> MyAddressPage()));
          }),
          _buildDivider(),
          _buildMenuItem(Icons.shopping_cart_outlined, 'Orders', () {}),
          _buildDivider(),
          _buildMenuItem(Icons.account_balance_wallet_outlined, 'Account', () {}),
          _buildDivider(),
          _buildMenuItem(Icons.notifications_outlined, 'Notifications', () {}),
          _buildDivider(),
          _buildMenuItem(Icons.devices_outlined, 'Devices', () {}),
          _buildDivider(),
          _buildMenuItem(Icons.language_outlined, 'Language', () {}),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue, size: 24),
      title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(height: 1, color: Color(0xFFE0E0E0)),
    );
  }
}
