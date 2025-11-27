import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../repositories/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  String _username = '';
  String _password = '';

  LoginBloc({required this.userRepository}) : super(LoginInitial()) {
    on<LoginUsernameChanged>((event, emit) {
      _username = event.username;
    });

    on<LoginPasswordChanged>((event, emit) {
      _password = event.password;
    });

    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final success = await userRepository.login(_username, _password);
        if (success) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure('Invalid username or password'));
        }
      } catch (_) {
        emit(LoginFailure('An unknown error occurred'));
      }
    });
  }
}
