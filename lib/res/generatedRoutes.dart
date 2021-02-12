import 'package:adva/ui/screens/bottomNavBar.dart';
import 'package:adva/ui/screens/homeScreen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final GlobalKey<ScaffoldState> key = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BottomNavBar(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      // case '/third':
      //   return MaterialPageRoute(
      //     builder: (_) => ThirdScreen(
      //       title: "Thirst Screen",
      //       color: Colors.greenAccent,
      //     ),
      //   );
      default:
        return null;
    }
  }
}
