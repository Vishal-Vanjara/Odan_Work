
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc_demo/demo_8/bloc/user3_event.dart';
import 'package:bloc_demo/demo_8/bloc/user3_state.dart';
import 'package:bloc_demo/demo_8/bloc/user3_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hive + BLoC Users")),
      body: Column(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(labelText: "Enter user name"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<UserBloc>().add(AddUserEvent(controller.text));
              controller.clear();
            },
            child: Text("Add User"),
          ),
          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoadedState) {
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.users[index].name),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            context.read<UserBloc>().add(DeleteUserEvent(index));
                          },
                        ),
                      );
                    },
                  );
                }
                return Center(child: Text("No Users Found"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
