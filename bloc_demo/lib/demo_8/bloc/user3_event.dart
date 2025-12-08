abstract class UserEvent {}

class LoadUsersEvent extends UserEvent {}

class AddUserEvent extends UserEvent {
  final String name;
  AddUserEvent(this.name);
}

class DeleteUserEvent extends UserEvent {
  final int index;
  DeleteUserEvent(this.index);
}
