import 'dart:async';
import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/ui/screens/accountsloginScreen.dart';
import 'package:adva/ui/screens/bottomNavBar.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  getPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool loggedIn = sharedPreferences.getBool('loggedIn');
    if (loggedIn == null || loggedIn == false) {
      await sharedPreferences.setBool("loggedIn", false);
      loggedIn = false;
      BlocProvider.of<UserLogInCubit>(context).setStatus(false);
    }

    Timer(
        Duration(seconds: 3),
        () => Navigator.push(context, MaterialPageRoute(builder: (_) {
              if (loggedIn)
                return BottomNavBar();
              else
                return AccountsLoginScreen();
            })));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Image.asset('assets/images/advalogo.png'),
                ),
              ),
              Text('Own your makeup'),
            ],
          ),
          CircularProgressIndicator(
            backgroundColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
