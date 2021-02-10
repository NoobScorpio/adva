import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Splash Screen

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => print('CallBack function'));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/advalogo.png'),
          ),
          Text('Own your makeup'),
        ],
      ),
    );
  }
}
