import 'package:adva/utils/myButton.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
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
          toolbarHeight: screenHeight * 0.09,
          leading: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.024),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.024, left: screenWidth * 0.22),
            child: Text(
              'Accounts',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        body: Column(children: [
          Center(
              child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.17),
            child: Text(
              'Enter OTP below',
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.25,
                    vertical: screenHeight * 0.023),
                child: PinPut(
                  fieldsCount: 4,
                  textStyle:
                      const TextStyle(fontSize: 22.0, color: Colors.black),
                  eachFieldWidth: 28.0,
                  eachFieldHeight: 30.0,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  pinAnimationType: PinAnimationType.fade,
                  onSubmit: (pin) async {
                    // try {
                    //   await FirebaseAuth.instance
                    //       .signInWithCredential(PhoneAuthProvider.credential(
                    //       verificationId: verificationCode, smsCode: pin))
                    //       .then((value) async {
                    //     if (value.user != null) {
                    //       Navigator.pushAndRemoveUntil(
                    //           context,
                    //           MaterialPageRoute(builder: (context) => Auth()),
                    //               (route) => false);
                    //       return  showDialog<void>(
                    //           context: context,
                    //           barrierDismissible: true,
                    //           builder:(BuildContext context) {
                    //             Future.delayed(Duration(seconds: 3),(){
                    //               Navigator.push(context, MaterialPageRoute(builder: (context) => Auth()));
                    //             });
                    //             return Congrats(screenHeight: screenHeight,screenWidth: screenWidth,);
                    //           }
                    //       );
                    //     }
                    //   });
                    // } catch (e) {
                    //   FocusScope.of(context).unfocus();
                    //   _scaffoldKey.currentState
                    //       .showSnackBar(SnackBar(content: Text('invalid OTP')));
                    // }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.22,
                  right: screenWidth * 0.22,
                ),
                child: MyButton(
                  height: screenHeight,
                  width: screenWidth,
                  child: Text('Post'),
                  onPressed: () {},
                ),
              ),
            ],
          )
        ]));
  }
}
