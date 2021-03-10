import 'package:adva/ui/screens/bottomNavBar.dart';
import 'package:adva/ui/screens/homeScreen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BottomNavBar(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );

      default:
        return null;
    }
  }
}
