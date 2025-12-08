import 'package:bloc_demo/demo_9/auth/auth_event.dart';
import 'package:bloc_demo/demo_9/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) => emit(AuthLoggedIn()));
    on<LogoutEvent>((event, emit) => emit(AuthLoggedOut()));
  }
}
