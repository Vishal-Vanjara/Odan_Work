import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxBool isLoading = false.obs;
  final RxBool isEditing = false.obs;

  final RxString displayName = ''.obs;
  final RxString email = ''.obs;
  final RxBool isOnline = false.obs;
  final Rx<DateTime?> joinedAt = Rx<DateTime?>(null);

  final displayNameController = TextEditingController();
  final passwordController = TextEditingController();

  User? get user => _auth.currentUser;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  /// 🔹 Fetch user data from Firestore (Real-time)
  void fetchUserProfile() {
    if (user == null) return;

    _firestore
        .collection('users')
        .doc(user!.uid)
        .snapshots()
        .listen((doc) {
      if (!doc.exists) return;

      final data = doc.data()!;
      displayName.value = data['displayName'] ?? '';
      email.value = data['email'] ?? '';
      isOnline.value = data['isOnline'] ?? false;

      final ts = data['createdAt'];
      if (ts != null) {
        joinedAt.value = (ts as Timestamp).toDate();
      }

      displayNameController.text = displayName.value;
    });
  }

  /// ✏ Update display name
  Future<void> updateDisplayName() async {
    if (user == null) return;

    isLoading.value = true;

    await _firestore.collection('users').doc(user!.uid).update({
      'displayName': displayNameController.text.trim(),
    });

    isEditing.value = false;
    isLoading.value = false;
  }

  /// 🔐 Change password
  Future<void> changePassword() async {
    if (user == null) return;

    try {
      isLoading.value = true;
      await user!.updatePassword(passwordController.text.trim());
      Get.back();
      Get.snackbar('Success', 'Password updated successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
      passwordController.clear();
    }
  }

  /// 🗑 Delete account
  Future<void> deleteAccount() async {
    if (user == null) return;

    try {
      isLoading.value = true;

      await _firestore.collection('users').doc(user!.uid).delete();
      await user!.delete();

      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// 🚪 Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }
}
