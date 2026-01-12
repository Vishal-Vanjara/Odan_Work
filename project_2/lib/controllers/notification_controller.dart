import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/notification_model.dart';

class NotificationController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isLoading = true.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  StreamSubscription? _sub;

  RxInt unreadCount = 0.obs;


  @override
  void onInit() {
    super.onInit();
    _listenToNotifications();
    listenToUnreadCount();
  }

  void listenToUnreadCount() {
    final user = _auth.currentUser;
    if (user == null) return;

    _firestore
        .collection('notifications')
        .doc(user.uid)
        .collection('items')
        .where('isRead', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      unreadCount.value = snapshot.docs.length;
    });
  }


  void _listenToNotifications() {
    final user = _auth.currentUser;
    if (user == null) {
      isLoading.value = false;
      return;
    }

    _sub = _firestore
        .collection('notifications')
        .doc(user.uid)
        .collection('items')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      notifications.value = snapshot.docs
          .map((e) => NotificationModel.fromMap(e.data()))
          .toList();

      isLoading.value = false;
    });
  }

  Future<void> markAsRead(String notificationId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('notifications')
        .doc(user.uid)
        .collection('items')
        .doc(notificationId)
        .update({'isRead': true});
  }

  @override
  void onClose() {
    _sub?.cancel();
    notifications.clear();
    super.onClose();
  }
}
