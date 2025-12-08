import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user1_bloc.dart';
import '../bloc/user1_event.dart';
import '../bloc/user1_states.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),

      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<UserBloc>().add(LoadUsersEvent());
                },
                child: Text("Load Users"),
              ),
            );
          }

          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is UserLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, i) {
                final user = state.users[i];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            );
          }

          if (state is UserError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          return SizedBox();
        },
      ),
    );
  }
}
