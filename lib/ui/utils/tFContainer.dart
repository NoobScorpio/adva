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
    return Container(
      height: 50,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.3, color: Colors.black),
          ),
        ),
        onSaved: (String value) {},
      ),
    );
  }
}
