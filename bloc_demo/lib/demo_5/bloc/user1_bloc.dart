import 'package:bloc_demo/demo_5/bloc/user1_event.dart';
import 'package:bloc_demo/demo_5/bloc/user1_states.dart';
import 'package:bloc_demo/demo_5/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserInitial()) {
    on<LoadUsersEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await repository.getUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
