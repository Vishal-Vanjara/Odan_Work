import 'package:bloc_demo/demo_2/bloc/login_bloc.dart';
import 'package:bloc_demo/demo_2/bloc/login_event.dart';
import 'package:bloc_demo/demo_2/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Form for BLoC"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            BlocBuilder<LoginBloc,LoginState>(
              builder: (context,state){
                return TextField(
                  onChanged: (value){
                    context.read<LoginBloc>().add(EmailChanged(value));
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    errorText: state.isEmailValid ? null :"Invalid Email",
                  ),
                );
              },
            ),

            SizedBox(height: 20,),

            BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return TextField(
                    obscureText: true,
                    onChanged: (value) {
                      context.read<LoginBloc>().add(PasswordChanged(value));
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      errorText:
                        state.isPasswordValid ? null:"Min 6 characters required",
                    ),
                  );
                },
            ),

            SizedBox(height: 30),

            // SUBMIT BUTTON
            ElevatedButton(
              onPressed: () {
                context.read<LoginBloc>().add(SubmitLogin());
              },
              child: Text("Login"),
            ),

            SizedBox(height: 20),

            // SUCCESS MESSAGE
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state.isSubmitted) {
                  return Text(
                    "Login Successful! 🎉",
                    style: TextStyle(color: Colors.green, fontSize: 18),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
