import 'package:bloc_demo/demo_3/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../user_model.dart';


class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text("Users List (API + BLoC)")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              userBloc.add(FetchUsersEvent());
            },
            child: const Text("Load Users"),
          ),

          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {

                if (state is UserInitial) {
                  return Center(child: Text("Click button to load users"));
                }

                if (state is UserLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is UserLoaded) {
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (_, index) {
                      UserModel user = state.users[index];
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

                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
