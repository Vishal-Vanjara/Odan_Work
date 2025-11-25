import 'package:flutter/material.dart';
import 'game/dash_game.dart';

void main() {
  runApp(const DashGameApp());
}

class DashGameApp extends StatelessWidget {
  const DashGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dash Game",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: DashGame(),
      ),
    );
  }
}
