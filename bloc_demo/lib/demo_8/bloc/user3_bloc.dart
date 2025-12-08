import 'package:bloc_demo/demo_8/bloc/user3_state.dart';
import 'package:bloc_demo/demo_8/bloc/user3_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_model.dart';
import '../repository/user_local_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserLocalRepository repository;

  UserBloc(this.repository) : super(UserInitial()) {
    on<LoadUsersEvent>((event, emit) {
      emit(UserLoadedState(repository.getUsers()));
    });

    on<AddUserEvent>((event, emit) async {
      await repository.addUser(UserModel(event.name));
      emit(UserLoadedState(repository.getUsers()));
    });

    on<DeleteUserEvent>((event, emit) async {
      await repository.deleteUser(event.index);
      emit(UserLoadedState(repository.getUsers()));
    });
  }
}
