import 'package:flutter/material.dart';

class GeneralContainer extends StatelessWidget {
  const GeneralContainer(
      {Key key,
      @required this.screenWidth,
      @required this.screenHeight,
      this.column})
      : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final Widget column;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        border: Border.all(width: 0.02),
        color: Colors.white,
      ),
      child: column,
    );
  }
}
