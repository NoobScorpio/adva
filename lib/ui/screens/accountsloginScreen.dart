import 'dart:convert';

import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/bloc/wishlist_bloc/wishCubit.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/screens/createAccount.dart';
import 'package:adva/ui/screens/forgetPassScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'bottomNavBar.dart';

class AccountsLoginScreen extends StatefulWidget {
  @override
  _AccountsLoginScreenState createState() => _AccountsLoginScreenState();
}

class _AccountsLoginScreenState extends State<AccountsLoginScreen> {
  SharedPreferences sharedPreferences;
  getPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  String username = '', pass = '';
  bool passH = true;
  @override
  Widget build(BuildContext context) {
    getPrefs();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap: (){Navigator.pop(context);}, child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        backgroundColor: Colors.white,
        // toolbarHeight: screenHeight * 0.09,
        title: Text(
          'Accounts',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ).tr(),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.06),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ).tr(),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Email or Phone no'.tr(),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        onChanged: (val) {
                          username = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        height: 60,
                        child: TextField(
                          obscureText: passH,
                          decoration: InputDecoration(
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  passH = !passH;
                                });
                              },
                              icon: Icon(Icons.remove_red_eye),
                            ),
                            hintText: 'Password'.tr(),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                          onChanged: (val) {
                            pass = val;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () async {
                      bool done = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ForgetPasswordScreen()));
                      if (done != null && done == true) {
                        showToast("Password Changed", primaryColor);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Forget Password?',
                        style: boldTextStyle,
                      ).tr(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: MyButton(
                    height: 60,
                    borderColor: Colors.transparent,
                    innerColor: primaryColor,
                    width: screenWidth,
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(color: Colors.white),
                    ).tr(),
                    onPressed: () async {
                      if (username != '' && pass != '') {
                        showToast("Logging In", primaryColor);
                        bool loggedIn =
                            await BlocProvider.of<UserCubit>(context)
                                .loginUser(username, pass);
                        print("USER LOGGED IN $loggedIn");
                        if (loggedIn) {
                          sharedPreferences.setBool('loggedIn', true);
                          await BlocProvider.of<UserCubit>(context).setStatus(true);
                          await BlocProvider.of<WishCubit>(context).getWishLists(
                              User.fromJson(json.decode(
                                      sharedPreferences.getString('user')))
                                  .id);
                          Navigator.pop(context);
                        } else {
                          sharedPreferences.setBool('loggedIn', false);
                          BlocProvider.of<UserCubit>(context).setStatus(false);
                        }
                      } else
                        showToast("Please fill the fields", primaryColor);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.013),
                  child: Text(
                    'or',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ).tr(),
                ),
                Text(
                  'Login with',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ).tr(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/socialmedia/facebooklogo.png'),
                      SizedBox(
                        width: 15,
                      ),
                      Image.asset('assets/socialmedia/googlelogo.png'),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateAccount()));
                  },
                  child: Text(
                    'Create New Account',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                    ),
                  ).tr(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
