import 'package:adva/screens/cartScreen.dart';
import 'package:adva/utils/constants.dart';
import 'package:flutter/material.dart';

class PaymentColumn extends StatelessWidget {
  const PaymentColumn({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
    this.flatShippingRate,
    this.subTotal,
    this.total,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final String flatShippingRate, subTotal, total;
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
          txt1: Text('SAR. $flatShippingRate',
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
            txt1: Text('SAR. $subTotal',
                style: TextStyle(
                  fontSize: 15,
                ))),
        CartRow(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            txt: Text('Total',
                style: TextStyle(fontSize: 15, color: cartTextColor)),
            txt1: Text('SAR. $total',
                style: TextStyle(fontSize: 15, color: cartTextColor))),
      ],
    );
  }
}
