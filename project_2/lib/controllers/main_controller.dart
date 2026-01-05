import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainController extends GetxController
    with WidgetsBindingObserver {

  /// bottom navigation index
  final RxInt currentIndex = 0.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _setOnline(true);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _setOnline(false);
    super.onClose();
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }

  /// app lifecycle listener
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _setOnline(true);
    } else {
      _setOnline(false);
    }
  }

  /// update online status in Firestore
  void _setOnline(bool isOnline) {
    final user = _auth.currentUser;
    if (user == null) return;

    _firestore.collection('users').doc(user.uid).update({
      'isOnline': isOnline,
      'lastSeen': FieldValue.serverTimestamp(),
    });
  }
}
