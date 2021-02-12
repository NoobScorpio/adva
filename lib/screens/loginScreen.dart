import 'package:adva/screens/accountsloginScreen.dart';
import 'package:adva/screens/otpScreen.dart';
import 'package:adva/utils/constants.dart';
import 'package:adva/utils/myButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.09,
        title: Center(
            child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.026),
          child: Text(
            'Accounts',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
        )),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: screenHeight * 0.08,
          ),
          Center(
            child: Text(
              'Login',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.01, bottom: screenHeight * 0.05),
            child: Divider(
              thickness: 0.5,
              color: cartTextColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 60,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Email or Phone no.',
                  suffix: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send,
                      color: primaryColor,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                // autofillHints: ['Type your comment here'],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 60,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffix: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send,
                      color: primaryColor,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                // autofillHints: ['Type your comment here'],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('Forget password?')],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MyButton(
              height: 55,
              width: double.maxFinite,
              innerColor: primaryColor,
              borderColor: Colors.transparent,
              child: Text(
                'SIGN IN',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(child: Text('or')),
          SizedBox(
            height: 5,
          ),
          Center(child: Text('Login with')),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                child: Icon(
                  FontAwesomeIcons.facebookF,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: primaryColor,
                child: Icon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Center(
              child: Text(
            'Create New Account',
            style: TextStyle(color: primaryColor),
          )),
        ],
      ),
    );
  }
}
