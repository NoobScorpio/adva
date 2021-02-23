import 'package:adva/bloc/cart_bloc/cartCubit.dart';
import 'package:adva/data/model/cartItem.dart';
import 'package:adva/ui/screens/categoryScreen.dart';
import 'package:adva/ui/screens/userScreen.dart';
import 'package:adva/ui/screens/cartScreen.dart';
import 'package:adva/ui/screens/categoriesScreen.dart';
import 'package:adva/ui/screens/galleryTabScreen.dart';
import 'package:adva/ui/screens/homeScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  String number;
  _BottomNavBarState({this.number});

  int _selectedIndex = 0;
  List<CartItem> cartItems;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  getItems() async {
    cartItems = [];
    cartItems = await BlocProvider.of<CartCubit>(context).getItems();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomeScreen(),
      ShopCategoryScreen(
        cid: "Makeup",
        brand: false,
      ),
      CartScreen(
        cartItems: cartItems,
      ),
      GalleryScreen(),
      UserScreen(),
    ];
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
                // Icon(
                //   Icons.home_filled,
                //   color: primaryColor,
                // ),
                SvgPicture.asset(
                  'assets/icons/Home-active.svg',
                ),
                // Image.asset('assets/icons/Home-active.svg'),
                Text(
                  'Home',
                  style: TextStyle(color: primaryColor),
                )
              ],
            ),
            label: 'Home',
            icon: Column(
              children: [
                // Icon(
                //   Icons.home_filled,
                // ),
                SvgPicture.asset(
                  'assets/icons/Home-grey.svg',
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
                SvgPicture.asset(
                  'assets/icons/Categories-active.svg',
                ),
                Text(
                  'Categories',
                  style: TextStyle(color: primaryColor),
                )
              ],
            ),
            label: 'Products',
            icon: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/Categories-grey.svg',
                ),
                Text(
                  'Products',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 25,
              child: SvgPicture.asset(
                'assets/icons/Cart-icon.svg',
                height: 25,
                width: 25,
              ),
            ),
            label: 'Cart',
            icon: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 25,
              child: SvgPicture.asset(
                'assets/icons/Cart-icon.svg',
                height: 30,
                width: 30,
              ),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/Gallery-active.svg',
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
                SvgPicture.asset(
                  'assets/icons/Gallery-grey.svg',
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
                SvgPicture.asset(
                  'assets/icons/Accounts-active.svg',
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
                SvgPicture.asset(
                  'assets/icons/Accounts-grey.svg',
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
