import 'dart:async';

import 'package:bloc_demo/demo_9/profile/profile_event.dart';
import 'package:bloc_demo/demo_9/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/auth_bloc.dart';
import '../auth/auth_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc authBloc;
  late final StreamSubscription authSubscription;

  ProfileBloc(this.authBloc) : super(ProfileInitial()) {

    // Listen to AuthBloc state changes
    authSubscription = authBloc.stream.listen((authState) {
      if (authState is AuthLoggedIn) {
        add(LoadProfileEvent());
      }
    });

    on<LoadProfileEvent>((event, emit) {
      emit(ProfileLoaded("John Doe")); // example data
    });
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
