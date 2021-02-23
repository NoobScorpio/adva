import 'package:adva/ui/screens/cartScreen.dart';
import 'package:adva/ui/utils/cartWidgets.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';

class PaymentColumn extends StatelessWidget {
  const PaymentColumn({
    Key key,
    this.flatShippingRate,
    this.subTotal,
    this.total,
  }) : super(key: key);

  final String flatShippingRate, subTotal, total;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Flat Shipping Rate',
                  style: TextStyle(
                    fontSize: 15,
                  )),
              Text('SAR. ${flatShippingRate ?? ""}',
                  style: TextStyle(
                    fontSize: 15,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sub Total',
                  style: TextStyle(
                    fontSize: 15,
                  )),
              Text('SAR. ${subTotal ?? ""}',
                  style: TextStyle(
                    fontSize: 15,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total(Inc. Vat)',
                  style: TextStyle(fontSize: 15, color: primaryColor)),
              Text('SAR. ${total ?? ""}',
                  style: TextStyle(fontSize: 15, color: primaryColor)),
            ],
          ),
        ),
      ],
    );
  }
}
