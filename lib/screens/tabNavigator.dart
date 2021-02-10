// import 'package:adva/utils/constants.dart';
// import 'package:custom_navigator/custom_navigation.dart';
// import 'package:flutter/material.dart';
// import 'package:adva/screens/accountScreen.dart';
// import 'package:adva/screens/cartScreen.dart';
// import 'package:adva/screens/categoriesScreen.dart';
// import 'package:adva/screens/galleryScreen.dart';
// import 'package:adva/screens/homeScreen.dart';

// class TabNavigator extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       scaffold: Scaffold(
//         bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//                 label: '', icon: Image.asset('assets/images/home.png')),
//             BottomNavigationBarItem(
//                 label: '', icon: Image.asset('assets/images/categories.png')),
//             BottomNavigationBarItem(
//                 label: '', icon: Image.asset('assets/images/cart.png')),
//             BottomNavigationBarItem(
//                 label: '', icon: Image.asset('assets/images/gallery.png')),
//             BottomNavigationBarItem(
//                 label: '', icon: Image.asset('assets/images/account.png')),
//           ],
//           // currentIndex: _selectedIndex,
//           selectedItemColor: primaryColor,
//           // onTap: _onItemTapped,
//           backgroundColor: Color(0xffffffff),
//           unselectedItemColor: Colors.grey,
//         ),
//       ),
//       children: [
//         HomeScreen(),
//         CategoriesScreen(),
//         CartScreeen(),
//         GalleryScreen(),
//         AccountScreen(),
//       ],
//     );
//   }
// }
