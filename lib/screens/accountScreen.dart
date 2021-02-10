import 'package:adva/paymentScreen.dart';
import 'package:adva/screens/claimScreen.dart';
import 'package:adva/screens/myPaymentScreen.dart';
import 'package:adva/screens/profileScreen.dart';
import 'package:adva/screens/wishlist.dart';
import 'package:adva/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'addressScreen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/advalogo.png',
                    height: 60,
                    width: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, John Doe',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                        ),
                      ),
                      Text(
                        'johndoe@gmail.com',
                        style: normalTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 110,
            width: double.maxFinite,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: primaryColor,
                          child: Icon(
                            Icons.fact_check_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Text('Orders'),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: primaryColor,
                          child: Icon(
                            Icons.assignment_return_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Text('Returns'),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: primaryColor,
                          child: Icon(
                            Icons.credit_card,
                            color: Colors.white,
                          ),
                        ),
                        Text('Adva points'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'My Account',
              style: boldTextStyle,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WishListScreen()));
            },
            child: ListTile(
              tileColor: Colors.white,
              leading: Icon(
                Icons.favorite,
                color: secondaryColor,
              ),
              title: Text('Wish list'),
            ),
          ),
          Divider(
            height: 1,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddressScreen()));
            },
            child: ListTile(
              tileColor: Colors.white,
              leading: Icon(
                Icons.location_pin,
                color: secondaryColor,
              ),
              title: Text('Addresses'),
            ),
          ),
          Divider(
            height: 1,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyPaymentScreen()));
            },
            child: ListTile(
              tileColor: Colors.white,
              leading: Icon(
                Icons.credit_card,
                color: secondaryColor,
              ),
              title: Text('Payment'),
            ),
          ),
          Divider(
            height: 1,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClaimScreen()));
            },
            child: ListTile(
              tileColor: Colors.white,
              leading: Icon(
                Icons.fact_check_outlined,
                color: secondaryColor,
              ),
              title: Text('Claims'),
            ),
          ),
          Divider(
            height: 1,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            child: ListTile(
              tileColor: Colors.white,
              leading: Icon(
                Icons.person_pin,
                color: secondaryColor,
              ),
              title: Text('Profile'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Settings',
              style: boldTextStyle,
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(
              Icons.flag,
              color: secondaryColor,
            ),
            title: Text('Language'),
            trailing: Text(
              'English',
              style: boldTextStyle,
            ),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(
              Icons.settings_outlined,
              color: secondaryColor,
            ),
            title: Text('Preferences'),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Reach Us',
              style: boldTextStyle,
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(
              Icons.help_outline,
              color: secondaryColor,
            ),
            title: Text('Help'),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.power_settings_new_outlined,
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Sign Out'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15),
                    child: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15),
                    child: Icon(
                      FontAwesomeIcons.twitter,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15),
                    child: Icon(
                      FontAwesomeIcons.instagram,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Privacy policy',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Terms & conditions',
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Copyrights',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.circle,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ADVA-2021',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      )),
    );
  }
}
