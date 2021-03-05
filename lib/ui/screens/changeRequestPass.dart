import 'package:adva/data/repository/userRepo.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangeRequestPasswordScreen extends StatefulWidget {
  final int cid;

  const ChangeRequestPasswordScreen({Key key, this.cid}) : super(key: key);
  @override
  _ChangeRequestPasswordScreenState createState() =>
      _ChangeRequestPasswordScreenState();
}

class _ChangeRequestPasswordScreenState
    extends State<ChangeRequestPasswordScreen> {
  String newPass = '', confirm = '';
  @override
  Widget build(BuildContext context) {
    print("USER ID : ${widget.cid}");
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
        ).tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Text(
                'Change Password',
                style: boldTextStyle,
              ).tr()
              ),
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
                'Make new password',
                style: boldTextStyle,
              ).tr()
              ),
            ),
            Center(
                child: Text(
              'Enter your password for next time login',
              style: TextStyle(color: Colors.grey),
            ).tr()
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter New Password'.tr(),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                onChanged: (val) {
                  newPass = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Confirm New Password'.tr(),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                onChanged: (val) {
                  confirm = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: MyButton(
                height: 55,
                onPressed: () async {
                  if (newPass == confirm && newPass != '' && confirm != '') {
                    bool changed = await UserRepositoryImpl()
                        .resetPassword(cid: widget.cid, pass: newPass);
                    if (changed)
                      Navigator.pop(context, true);
                    else
                      showToast("Something went wrong", primaryColor);
                  }
                },
                innerColor: primaryColor,
                borderColor: Colors.transparent,
                child: Text(
                  'Save and Continue',
                  style: TextStyle(color: Colors.white),
                ).tr(),
              ),
            ),
            SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}
