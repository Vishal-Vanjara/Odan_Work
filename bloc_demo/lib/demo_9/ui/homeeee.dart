import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_demo/demo_9/profile/profile_state.dart';

import '../auth/auth_bloc.dart';
import '../auth/auth_event.dart';
import '../auth/auth_state.dart';
import '../profile/profile_bloc.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Multi BLoC Communication")),
      body: Column(
        children: [
          SizedBox(height: 40),

          /// LOGIN BUTTON (AuthBloc)
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(LoginEvent());
            },
            child: Text("Login"),
          ),

          SizedBox(height: 20),

          /// SHOW AUTH STATE
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoggedIn) {
                return Text("Status: Logged In",
                    style: TextStyle(fontSize: 18));
              }
              if (state is AuthLoggedOut) {
                return Text("Status: Logged Out",
                    style: TextStyle(fontSize: 18));
              }
              return Text("Status: Initial");
            },
          ),

          SizedBox(height: 40),

          /// PROFILE (Listens to AuthBloc)
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return Text("Profile: ${state.username}",
                    style: TextStyle(fontSize: 20));
              }
              return Text("Profile not loaded");
            },
          ),
        ],
      ),
    );
  }
}
