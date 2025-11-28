import 'package:bloc_demo/demo_2/bloc/login_event.dart';
import 'package:bloc_demo/demo_2/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(
        email: event.email, isEmailValid: event.email.contains("@"),
      ));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(
        password: event.password, isPasswordValid: event.password.length >= 4,
      ));
    });

    on<SubmitLogin>((event, emit) {
      final validEmail = state.email.contains("@");
      final validPasword = state.password.length >= 4;

      emit(state.copyWith(isEmailValid: validEmail,
        isPasswordValid: validPasword,
        isSubmitted: validPasword && validEmail,
      ));
    });
  }
}