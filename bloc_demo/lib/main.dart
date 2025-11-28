// //<-------------main.dart code for demo ----------------------->
// import 'package:bloc_demo/demo/counter_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'demo/bloc.dart';
//
// void main(){
//   runApp(
//     BlocProvider(create: (_) => CounterBloc(),
//     child: const MyApp(),)
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CounterPage(),
//     );
//   }
// }



// //<-------------main.dart code for demo-2 ----------------------->
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'demo_2/bloc/login_bloc.dart';
// import 'demo_2/screens/login_page.dart';
//
// void main() {
//   runApp(
//     BlocProvider(
//       create: (_) => LoginBloc(),
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoginPage(),
//     );
//   }
// }

import 'dart:ui';

import 'package:bloc_demo/demo_3/api_service.dart';
import 'package:flutter/cupertino.dart' show runApp;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'demo_3/bloc/user_bloc.dart';
import 'demo_3/screens/user_page.dart';

void main(){
  runApp(
    BlocProvider(
      create:(_) => UserBloc(ApiServices()),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserPage(),
    );
  }
}
