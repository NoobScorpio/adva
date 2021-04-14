import 'dart:async';

import 'package:adva/ui/screens/accountsloginScreen.dart';
import 'package:adva/ui/screens/chatbotScreen.dart';
import 'package:adva/ui/screens/createAccount.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInSignUp extends StatefulWidget {
  @override
  _SignInSignUpState createState() => _SignInSignUpState();
}

class _SignInSignUpState extends State<SignInSignUp> {
  bool english = false;
  SharedPreferences sp;
  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  getPrefs() async {
    sp = await SharedPreferences.getInstance();
    bool lang = sp.getBool('lang');
    if (lang == null || lang == true) {
      setState(() {
        english = false;
      });
    } else {
      setState(() {
        english = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: ListView(
        children: [
          SizedBox(
            height: screenHeight * 0.001,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/advalogo.png',
                  scale: 3,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Welcome to ADVA',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ).tr(),
                  Text(
                    'Own your makeup',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ).tr()
                ],
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountsLoginScreen()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: primaryColor,
                          child: Icon(
                            Icons.person_outline_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Text('Sign In').tr(),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAccount()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: primaryColor,
                          child: Icon(
                            Icons.person_add_alt_1_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Text('Sign Up').tr(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Settings',
              style: boldTextStyle,
            ).tr(),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            width: double.maxFinite,
            child: GestureDetector(
              onTap: () async {
                showDialog(context: context, builder: (_) => buildLoading());
                if (english) {
                  context.setLocale(Locale('ar', 'AE'));
                  setState(() {
                    english = false;
                  });
                  await sp.setBool('lang', english);
                } else {
                  context.setLocale(Locale('en', ''));
                  setState(() {
                    english = true;
                  });
                  await sp.setBool('lang', english);
                }
                Timer(Duration(seconds: 1), () => Navigator.pop(context));
              },
              child: ListTile(
                tileColor: Colors.white,
                leading: Icon(
                  Icons.flag,
                  color: secondaryColor,
                ),
                title: Text('Language').tr(),
                trailing: Text(
                  english ? 'Arabic' : "English",
                  style: boldTextStyle,
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Reach Us',
              style: boldTextStyle,
            ).tr(),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            width: double.maxFinite,
            child: GestureDetector(
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
          ),
          SizedBox(
            height: screenHeight * 0.1,
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ChatBotScreen()));
        },
        child: Icon(Icons.question_answer_outlined),
      ),
    );
  }
}
