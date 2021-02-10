import 'package:adva/utils/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key key,
    @required this.screenWidth,
    @required this.screenHeight,
    this.txt,
    this.onpressed,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final onpressed;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.03,
        right: screenWidth * 0.03,
      ),
      child: Container(
        height: screenHeight * 0.05,
        width: screenWidth,
        child: FlatButton(
          color: primaryColor,
          onPressed: onpressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                txt,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
