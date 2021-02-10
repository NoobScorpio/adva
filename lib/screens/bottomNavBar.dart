import 'package:adva/screens/userScreen.dart';
import 'package:adva/screens/cartScreen.dart';
import 'package:adva/screens/categoriesScreen.dart';
import 'package:adva/screens/galleryTabScreen.dart';
import 'package:adva/screens/homeScreen.dart';
import 'package:adva/utils/constants.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  String number;
  _BottomNavBarState({this.number});

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CategoriesScreen(),
    CartScreeen(),
    GalleryScreen(),
    UserScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              activeIcon: Image.asset('assets/bottomNav/homeActive.png'),
              label: 'Home',
              icon: Image.asset('assets/bottomNav/home.png')),
          BottomNavigationBarItem(
              activeIcon: Image.asset('assets/bottomNav/categoriesActive.png'),
              label: 'Categories',
              icon: Image.asset('assets/bottomNav/categories.png')),
          BottomNavigationBarItem(
              activeIcon: Image.asset('assets/bottomNav/cartActive.png'),
              label: 'Cart',
              icon: Image.asset('assets/bottomNav/cart.png')),
          BottomNavigationBarItem(
              activeIcon: Image.asset('assets/bottomNav/galleryActive.png'),
              label: 'Gallery',
              icon: Image.asset('assets/bottomNav/gallery.png')),
          BottomNavigationBarItem(
              activeIcon: Image.asset('assets/bottomNav/accountActive.png'),
              label: 'Account',
              icon: Image.asset('assets/bottomNav/account.png')),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onItemTapped,
        backgroundColor: Color(0xffffffff),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
