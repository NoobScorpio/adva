import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangePasswordScreen extends StatefulWidget {
  final User user;

  const ChangePasswordScreen({Key key, this.user}) : super(key: key);
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String pass = '', newPass = '', confirmPass = '';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
              height: 60,
              width: 60,
              child: Image.asset('assets/images/advalogo.png')),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: boldTextStyle,
                  ).tr(),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Current Password',
                    style: boldTextStyle,
                  ).tr(),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your current password'.tr(),
                      suffixIcon: Icon(Icons.remove_red_eye),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    onChanged: (val) {
                      pass = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'New Password',
                    style: boldTextStyle,
                  ).tr(),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your new password'.tr(),
                      suffixIcon: Icon(Icons.remove_red_eye),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    onChanged: (val) {
                      newPass = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Confirm Password',
                    style: boldTextStyle,
                  ).tr(),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Confirm your Password '.tr(),
                      suffixIcon: Icon(Icons.remove_red_eye),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    onChanged: (val) {
                      confirmPass = val;
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                width: double.maxFinite,
                child: RaisedButton(
                  onPressed: () async {
                    if (pass != '' && confirmPass != '' && newPass != '') {
                      if (confirmPass == newPass) {
                        bool updated = await BlocProvider.of<UserCubit>(context)
                            .updatePass(widget.user, pass, newPass);
                        if (updated) {
                          showToast("Password Updated", primaryColor);
                          Navigator.pop(context);
                        } else {
                          showToast("Password not updated", primaryColor);
                        }
                      } else
                        showToast("Passwords do not match", primaryColor);
                    } else {
                      showToast("Please fill all fields", primaryColor);
                    }
                  },
                  color: primaryColor,
                  child: Text(
                    'Change Password',
                    style: TextStyle(color: Colors.white),
                  ).tr(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
