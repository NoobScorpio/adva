import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatefulWidget {
  final bool product;

  const LoginScreen({Key key, this.product}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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
          ).tr(),
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
            ).tr(),
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
                  hintText: 'Enter Email or Phone no.'.tr(),
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
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 60,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Password'.tr(),
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
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('Forget password?').tr()],
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
              ).tr(),
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(child: Text('or').tr()),
          SizedBox(
            height: 5,
          ),
          Center(child: Text('Login with').tr()),
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
          ).tr()),
        ],
      ),
    );
  }
}
