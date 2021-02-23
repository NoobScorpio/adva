import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/data/repository/userRepo.dart';
import 'package:adva/ui/screens/verificationScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String ep = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          'Accounts',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Text(
                'Forgot Password',
                style: boldTextStyle,
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Text(
                'Verification code will be send to you',
                style: boldTextStyle,
              )),
            ),
            Center(
                child: Text(
              'don\'t worry we are just making sure that its you',
              style: TextStyle(color: Colors.grey),
            )),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Email or Phone no',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                onChanged: (val) {
                  ep = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: MyButton(
                height: 55,
                onPressed: () async {
                  if (ep != '') {
                    showToast("Sending Request", primaryColor);
                    bool sendRequest = await UserRepositoryImpl()
                        .sendForgetPasswordNewRequest(ep);
                    if (sendRequest) {
                      bool done = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => VerificationScreen(email: ep)));
                      if (done != null && done == true) {
                        Navigator.pop(context, true);
                      }
                    } else {
                      showToast("Something went wrong", primaryColor);
                    }
                  } else {
                    showToast("Fill the required field", primaryColor);
                  }
                },
                innerColor: primaryColor,
                borderColor: Colors.transparent,
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Text(
                  'Go back to Login',
                  style: TextStyle(color: primaryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
