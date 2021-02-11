import 'package:adva/screens/bottomNavBar.dart';
import 'package:adva/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ADVA',
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: GoogleFonts.caudexTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}
