import 'package:hive/hive.dart';
import '../models/user_model.dart';

class UserLocalRepository {
  Box<UserModel> box = Hive.box<UserModel>('usersBox');

  List<UserModel> getUsers() {
    return box.values.toList();
  }

  Future<void> addUser(UserModel user) async {
    await box.add(user);
  }

  Future<void> deleteUser(int index) async {
    await box.deleteAt(index);
  }
}
