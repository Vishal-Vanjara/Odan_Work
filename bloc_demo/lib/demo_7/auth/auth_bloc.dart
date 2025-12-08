import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:bloc_demo/demo_7/auth/auth_event.dart';
import 'package:bloc_demo/demo_7/auth/auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc() : super(AuthInitial()){
    on<LoginEvent>((event,emit){
      emit(Authenticated());
    });

    on<LogoutEvent>((event,emit){
      emit(Unauthenticated());
    });
  }
}