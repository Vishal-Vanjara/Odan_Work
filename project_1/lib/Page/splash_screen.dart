import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_1/Page/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return LoginScreen();
      })
      );}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image(
            image: AssetImage("assets/bag5.jpeg"),
            fit: BoxFit.fill,
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 50),
              child: Text(
            "Loading...",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
          )),
        ),
      ]),
    );
  }
}
