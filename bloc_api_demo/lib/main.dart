import 'package:flutter/material.dart';
import 'bloc/api_bloc.dart';
import 'repository/api_repository.dart';
import 'ui/home_page.dart';


void main() {
  final repository = ApiRepository();
  final bloc = ApiBloc(repository);


  runApp(MyApp(bloc: bloc));
}


class MyApp extends StatelessWidget {
  final ApiBloc bloc;
  const MyApp({required this.bloc});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(bloc: bloc),
    );
  }
}