import '../models/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadedState extends UserState {
  final List<UserModel> users;
  UserLoadedState(this.users);
}
