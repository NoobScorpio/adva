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
    CartScreen(),
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
            activeIcon: Column(
              children: [
                Icon(
                  Icons.home_filled,
                  color: primaryColor,
                ),
                Text(
                  'Home',
                  style: TextStyle(color: primaryColor),
                )
              ],
            ),
            label: 'Home',
            icon: Column(
              children: [
                Icon(
                  Icons.home_filled,
                ),
                Text(
                  'Home',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Column(
              children: [
                Icon(
                  Icons.category_rounded,
                  color: primaryColor,
                ),
                Text(
                  'Categories',
                  style: TextStyle(color: primaryColor),
                )
              ],
            ),
            label: 'Category',
            icon: Column(
              children: [
                Icon(
                  Icons.category_rounded,
                ),
                Text(
                  'Category',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 25,
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
            label: 'Cart',
            icon: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 25,
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Column(
              children: [
                Icon(
                  Icons.photo_library_rounded,
                  color: primaryColor,
                ),
                Text(
                  'Gallery',
                  style: TextStyle(color: primaryColor),
                )
              ],
            ),
            label: 'Gallery',
            icon: Column(
              children: [
                Icon(
                  Icons.photo_library_rounded,
                ),
                Text(
                  'Gallery',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Column(
              children: [
                Icon(
                  Icons.person,
                  color: primaryColor,
                ),
                Text(
                  'Account',
                  style: TextStyle(color: primaryColor),
                )
              ],
            ),
            label: 'Account',
            icon: Column(
              children: [
                Icon(
                  Icons.person,
                ),
                Text(
                  'Account',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
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
