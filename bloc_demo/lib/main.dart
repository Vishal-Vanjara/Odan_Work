import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'repositories/user_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Instantiate UserRepository here and pass it down
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLoC Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(userRepository: userRepository),
    );
  }
}
