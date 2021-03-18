import 'package:adva/bloc/cart_bloc/cartCubit.dart';
import 'package:adva/bloc/featured_bloc/getFeaturedCubit.dart';
import 'package:adva/data/model/cartItem.dart';
import 'package:adva/data/model/featured.dart';
import 'package:adva/data/model/searchProduct.dart';
import 'package:adva/ui/screens/categoryScreen.dart';
import 'package:adva/ui/screens/userScreen.dart';
import 'package:adva/ui/screens/cartScreen.dart';
import 'package:adva/ui/screens/galleryScreen.dart';
import 'package:adva/ui/screens/homeScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

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

  List<SearchProduct> searches = [];
  @override
  void initState() {
    super.initState();

    getItems();
  }

  getSearch() async {
    List<Featured> feat =
        await BlocProvider.of<GetFeaturedCubit>(context).getSellers();
    for (Featured f in feat) {
      searches.add(SearchProduct(
          productName: context.locale == Locale('en', '')
              ? f.productName
              : f.productArabicName,
          id: f.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => getSearch());
    List<Widget> _widgetOptions = <Widget>[
      HomeScreen(search: searches),
      ShopCategoryScreen(cid: "Makeup", brand: false, search: searches),
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
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.white,
          selectedItemBackgroundColor: primaryColor,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
        ),
        items: [
          FFNavigationBarItem(
            iconData: Icons.home,
            label: 'Home'.tr(),
          ),
          FFNavigationBarItem(
            iconData: Icons.category,
            label: 'Category'.tr(),
          ),
          FFNavigationBarItem(
            iconData: Icons.shopping_cart_outlined,
            label: 'Cart'.tr(),
          ),
          FFNavigationBarItem(
            iconData: Icons.image_outlined,
            label: 'Gallery'.tr(),
          ),
          FFNavigationBarItem(
            iconData: Icons.person_outlined,
            label: 'Account'.tr(),
          ),
        ],
        selectedIndex: _selectedIndex,
        onSelectTab: _onItemTapped,
      ),
    );
  }
}
