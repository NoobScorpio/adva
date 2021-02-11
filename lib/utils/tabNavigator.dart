import 'package:adva/screens/cartScreen.dart';
import 'package:adva/screens/categoriesScreen.dart';
import 'package:adva/screens/galleryTabScreen.dart';
import 'package:adva/screens/homeScreen.dart';
import 'package:adva/screens/userScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  const TabNavigator({Key key, this.navigatorKey, this.tabItem})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget child;

    if (tabItem == "0")
      child = HomeScreen();
    else if (tabItem == "1")
      child = CategoriesScreen();
    else if (tabItem == "2")
      child = CartScreen();
    else if (tabItem == "3")
      child = GalleryScreen();
    else if (tabItem == "4") child = UserScreen();
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
