import 'package:adva/screens/userScreen.dart';
import 'package:adva/screens/bottomNavBar.dart';
import 'package:adva/utils/constants.dart';
import 'package:adva/utils/myButton.dart';
import 'package:flutter/material.dart';

class AccountsLoginScreen extends StatefulWidget {
  @override
  _AccountsLoginScreenState createState() => _AccountsLoginScreenState();
}

class _AccountsLoginScreenState extends State<AccountsLoginScreen> {
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
          padding: EdgeInsets.only(
              top: screenHeight * 0.026, right: screenWidth * 0.12),
          child: Text(
            'Accounts',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
        )),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.06),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.1),
                  child: HTFContainer(
                    screenHeight: screenHeight,
                    hintT: 'Enter Email or Phone no.',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.02,
                right: screenWidth * 0.02,
                top: screenHeight * 0.03),
            child: MyButton(
              height: screenHeight,
              width: screenWidth,
              child: Text('Post'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BottomNavBar()));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.013),
            child: Text(
              'or',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          Text(
            'Login with',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/socialmedia/facebooklogo.png'),
              SizedBox(
                width: screenWidth * 0.03,
                height: screenHeight * 0.07,
              ),
              Image.asset('assets/socialmedia/googlelogo.png'),
            ],
          ),
          SizedBox(height: screenHeight * 0.23),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserScreen()));
            },
            child: Text(
              'Create New Account',
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                decoration: TextDecoration.underline,
                decorationColor: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HTFContainer extends StatelessWidget {
  const HTFContainer({
    Key key,
    @required this.screenHeight,
    this.hintT,
  }) : super(key: key);

  final double screenHeight;
  final String hintT;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.06,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
          hintText: hintT,
          contentPadding: EdgeInsets.only(top: 1, left: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.6, color: Colors.black),
          ),
        ),
        onSaved: (String value) {},
      ),
    );
  }
}
