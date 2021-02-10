import 'package:flutter/material.dart';

class TFContainer extends StatelessWidget {
  const TFContainer({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: screenWidth * 0.03,
          left: screenWidth * 0.024,
          top: screenHeight * 0.003),
      child: Container(
        height: screenHeight * 0.06,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.always,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.3, color: Colors.black),
            ),
          ),
          onSaved: (String value) {},
        ),
      ),
    );
  }
}
