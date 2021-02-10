import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  WhiteButton({this.screenWidth, this.txt});

  final double screenWidth;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.25,
      decoration:
          BoxDecoration(border: Border.all(width: 0.1, color: Colors.black)),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
