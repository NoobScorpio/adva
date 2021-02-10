import 'package:adva/screens/cartScreen.dart';
import 'package:adva/utils/constants.dart';
import 'package:flutter/material.dart';

class PaymentColumn extends StatelessWidget {
  const PaymentColumn({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CartRow(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          txt: Text('Flat Shipping Rate',
              style: TextStyle(
                fontSize: 15,
              )),
          txt1: Text('SAR. 999',
              style: TextStyle(
                fontSize: 15,
              )),
        ),
        CartRow(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            txt: Text('Sub - Total',
                style: TextStyle(
                  fontSize: 15,
                )),
            txt1: Text('SAR. 999',
                style: TextStyle(
                  fontSize: 15,
                ))),
        CartRow(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            txt: Text('Total',
                style: TextStyle(fontSize: 15, color: cartTextColor)),
            txt1: Text('SAR. 999',
                style: TextStyle(fontSize: 15, color: cartTextColor))),
      ],
    );
  }
}
