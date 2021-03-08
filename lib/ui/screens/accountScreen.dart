import 'dart:convert';
import 'package:adva/bloc/address_bloc/addressCubit.dart';
import 'package:adva/bloc/category_bloc/getCategoryCubit.dart';
import 'package:adva/bloc/featured_bloc/getFeaturedCubit.dart';
import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/bloc/user_bloc/userState.dart';
import 'package:adva/bloc/wishlist_bloc/wishCubit.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/screens/addressScreen.dart';
import 'package:adva/ui/screens/advaPointsScreen.dart';
import 'package:adva/ui/screens/claimScreen.dart';
import 'package:adva/ui/screens/myPaymentScreen.dart';
import 'package:adva/ui/screens/profileScreen.dart';
import 'package:adva/ui/screens/refundScreen.dart';
import 'package:adva/ui/screens/userOrdersScreen.dart';
import 'package:adva/ui/screens/userReturnsScreen.dart';
import 'package:adva/ui/screens/wishlist.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLang();
    BlocProvider.of<UserCubit>(context).getUser();
  }

  getLang() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    english = sp.getBool('english') ?? true;
  }

  bool english;
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
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserInitialState)
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                              ),
                            ),
                            Text(
                              '',
                              style: normalTextStyle,
                            ),
                          ],
                        ),
                      );
                    else if (state is UserLoadingState)
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                              ),
                            ),
                            Text(
                              '',
                              style: normalTextStyle,
                            ),
                          ],
                        ),
                      );
                    else if (state is GetUserLoggedInState) {
                      if (state.user.id != null) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${state.user.firstName + " " + state.user.lastName}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 21,
                                ),
                              ),
                              Text(
                                '${state.user.email}',
                                style: normalTextStyle,
                              ),
                            ],
                          ),
                        );
                      }
                      // BlocProvider.of<UserLogInCubit>(context).
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                              ),
                            ),
                            Text(
                              '',
                              style: normalTextStyle,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                              ),
                            ),
                            Text(
                              '',
                              style: normalTextStyle,
                            ),
                          ],
                        ),
                      );
                    }
                  },
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
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        User user =
                            User.fromJson(json.decode(sp.getString('user')));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserOrdersScreen(user: user)));
                      },
                      child: Column(
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
                          Text('Orders').tr(),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        User user =
                            User.fromJson(json.decode(sp.getString('user')));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserReturnsScreen(
                                      user: user,
                                    )));
                      },
                      child: Column(
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
                          Text('Returns').tr(),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        User user =
                            User.fromJson(json.decode(sp.getString('user')));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ADVAPointsScreen(user: user)));
                      },
                      child: Column(
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
                          Text('ADVA points').tr(),
                        ],
                      ),
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
            ).tr(),
          ),
          GestureDetector(
            onTap: () async {
              SharedPreferences sp = await SharedPreferences.getInstance();
              User user = User.fromJson(json.decode(sp.getString('user')));
              BlocProvider.of<WishCubit>(context).getWishLists(user.id);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WishListScreen()));
            },
            child: ListTile(
              tileColor: Colors.white,
              leading: Icon(
                Icons.favorite,
                color: secondaryColor,
              ),
              title: Text('Wish list').tr(),
            ),
          ),
          Divider(
            height: 1,
          ),
          GestureDetector(
            onTap: () async {
              SharedPreferences sp = await SharedPreferences.getInstance();
              User user = User.fromJson(json.decode(sp.getString('user')));
              BlocProvider.of<AddressCubit>(context).getAddresses(user.id);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddressScreen(user: user)));
            },
            child: ListTile(
              tileColor: Colors.white,
              leading: Icon(
                Icons.location_pin,
                color: secondaryColor,
              ),
              title: Text('Addresses').tr(),
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
              title: Text('Payment').tr(),
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
              title: Text('Claims').tr(),
            ),
          ),
          Divider(
            height: 1,
          ),
          GestureDetector(
            onTap: () async {
              SharedPreferences sp = await SharedPreferences.getInstance();
              User user = User.fromJson(json.decode(sp.getString('user')));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(user: user)));
            },
            child: ListTile(
              tileColor: Colors.white,
              leading: Icon(
                Icons.person_pin,
                color: secondaryColor,
              ),
              title: Text('Profile').tr(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Settings',
              style: boldTextStyle,
            ).tr(),
          ),
          GestureDetector(
            onTap: () async {
              // languageBottomSheet(context);
              SharedPreferences sp = await SharedPreferences.getInstance();
              if (english) {
                context.locale = Locale('ar', 'AE');
                setState(() {
                  english = false;
                });
                await sp.setBool('english', false);
              } else {
                context.locale = Locale('en', '');
                setState(() {
                  english = true;
                });
                await sp.setBool('english', true);
              }
              await BlocProvider.of<GetCategoryCubit>(context).getCategories();
              await BlocProvider.of<GetFeaturedCubit>(context).getSellers();
            },
            child: ListTile(
              tileColor: Colors.white,
              leading: Icon(
                Icons.flag,
                color: secondaryColor,
              ),
              title: Text('Language').tr(),
              trailing: Text(
                english ?? true ? 'English' : "Arabic",
                style: boldTextStyle,
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RefundScreen()));
            },
            child: ListTile(
              tileColor: Colors.white,
              leading: Icon(
                Icons.settings_outlined,
                color: secondaryColor,
              ),
              title: Text('Preferences').tr(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Reach Us',
              style: boldTextStyle,
            ).tr(),
          ),
          GestureDetector(
            onTap: () async {
              const url = 'https://advabeauty.com/faqs';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: ListTile(
              tileColor: Colors.white,
              leading: Icon(
                Icons.help_outline,
                color: secondaryColor,
              ),
              title: Text('Help').tr(),
            ),
          ),
          GestureDetector(
            onTap: () async {
              showToast("Logging out...", primaryColor);
              SharedPreferences sp = await SharedPreferences.getInstance();
              sp.setString('user', null);
              sp.setString('cart', null);
              sp.setBool('loggedIn', false);
              BlocProvider.of<UserCubit>(context).setStatus(false);
              BlocProvider.of<UserCubit>(context).logOut();
              // setState(() {});
            },
            child: Padding(
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
                    child: Text('Sign Out').tr(),
                  )
                ],
              ),
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
                ).tr(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Terms & conditions',
                  style: TextStyle(fontSize: 12),
                ).tr(),
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
                    ).tr(),
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

  void languageBottomSheet(con) {
    showModalBottomSheet(
        context: con,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Language',
                    style: boldTextStyle,
                  ).tr(),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Divider(
                        color: Colors.grey,
                      ),
                      GestureDetector(
                        onTap: () {
                          con.locale = Locale('en', '');
                          // setState(() {
                          //   english = true;
                          // });
                        },
                        child: ListTile(
                          title: Text('English'),
                          trailing: Icon(
                            Icons.check_circle,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      GestureDetector(
                        onTap: () {
                          con.locale = Locale('ar', '');
                          // setState(() {
                          //   english = false;
                          // });
                        },
                        child: ListTile(
                          title: Text('Arabic'),
                          trailing: Icon(
                            Icons.circle,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
