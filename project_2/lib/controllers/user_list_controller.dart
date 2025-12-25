import 'package:get/get.dart';
import '../models/users_model.dart';
import '../services/firebase_services.dart';

class UserListController extends GetxController {
  final FirebaseServices _firebaseServices = FirebaseServices();

  final RxList<UserModel> users = <UserModel>[].obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUsers();
  }

  void _loadUsers() {
    _firebaseServices.getAllUsers().listen((userList) {
      users.value = userList;
    });
  }

  List<UserModel> get filteredUsers {
    if (searchQuery.value.isEmpty) return users;
    return users.where((user) {
      return user.displayName
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase()) ||
          user.email
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
    }).toList();
  }

  Future<void> sendRequest(String userId) async {
    await _firebaseServices.sendFriendRequest(userId);
  }

  Future<void> cancelRequest(String userId) async {
    await _firebaseServices.cancelFriendRequest(userId);
  }

  Future<bool> hasRequest(String userId) async {
    return await _firebaseServices.hasPendingRequest(userId);
  }
}
