import 'package:adva/data/repository/userRepo.dart';
import 'package:adva/ui/screens/changeRequestPass.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:easy_localization/easy_localization.dart';

class VerificationScreen extends StatefulWidget {
  final email;

  const VerificationScreen({Key key, this.email}) : super(key: key);
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.transparent,
    border: Border.symmetric(
      vertical: BorderSide(width: 1, color: Colors.black),
      horizontal: BorderSide(width: 1, color: Colors.black),
    ),
  );

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
            ),
          ),
          title: Text(
            'Accounts',
            style: TextStyle(
              color: Colors.black,
            ),
          ).tr(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Text(
                'Verification',
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
                'Verification code',
                style: boldTextStyle,
              ).tr()
              ),
            ),
            Center(
                child: Text(
              'Please enter the 4 digit verification code we have just sent you',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ).tr()
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: PinPut(
                fieldsCount: 4,
                textStyle: const TextStyle(fontSize: 22.0, color: Colors.black),
                eachFieldWidth: 60.0,
                eachFieldHeight: 60.0,
                keyboardType: TextInputType.number,
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: pinPutDecoration,
                selectedFieldDecoration: pinPutDecoration,
                followingFieldDecoration: pinPutDecoration,
                pinAnimationType: PinAnimationType.fade,
                onChanged: (pin) async {
                  verificationCode = pin;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Center(
                  child: Row(
                children: [
                  Text(
                    'Didn\'t receive the code? ',
                  ).tr(),
                  Text(
                    'Resend',
                    style: TextStyle(color: primaryColor),
                  ).tr(),
                ],
              )),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.22,
                right: screenWidth * 0.22,
              ),
              child: MyButton(
                height: 55,
                innerColor: primaryColor,
                width: double.maxFinite,
                borderColor: Colors.transparent,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ).tr(),
                onPressed: () async {
                  showToast("Verifying", primaryColor);
                  int verify = await UserRepositoryImpl()
                      .sendForgetPasswordCodeVerifyRequest(
                          widget.email, verificationCode);
                  if (verify != null) {
                    bool done = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChangeRequestPasswordScreen(cid: verify)));
                    if (done != null && done == true) {
                      Navigator.pop(context, true);
                    }
                  } else
                    showToast("Something went wrong", primaryColor);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: primaryColor),
                  ).tr(),
                ),
              ),
            )
          ]),
        ));
  }
}
