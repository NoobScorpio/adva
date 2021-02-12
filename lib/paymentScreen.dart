import 'dart:ui';

import 'package:adva/screens/addCardScreen.dart';
import 'package:adva/screens/orderDetailsScreen.dart';
import 'package:adva/utils/constants.dart';
import 'package:adva/utils/myButton.dart';
import 'package:adva/utils/paymentColumn.dart';
import 'package:adva/utils/roundDoneContainer.dart';
import 'package:adva/utils/tFContainer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int groupValue1 = 1, groupValue2 = 0;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.12,
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.2, top: screenHeight * 0.04),
          child: Text(
            'Payments',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Container(
              color: Colors.white,
              width: screenWidth,
              height: screenHeight * 0.25,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Method',
                      style: TextStyle(color: cartTextColor),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.03,
                          bottom: screenHeight * 0.01),
                      child: Container(
                        height: screenHeight * 0.07,
                        decoration:
                            BoxDecoration(border: Border.all(width: 0.5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Image.asset('assets/images/visa2.png'),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 39),
                                child: Image.asset(
                                    'assets/images/mastercard2.png'),
                              ),
                              Text('Card Payment'),
                              SizedBox(
                                width: screenWidth * 0.18,
                              ),
                              Radio(
                                value: 1,
                                groupValue: groupValue1,
                                onChanged: (newValue) =>
                                    setState(() => groupValue1 = newValue),
                                activeColor: primaryColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(border: Border.all(width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Image.asset('assets/images/cash.png'),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: screenWidth * 0.24),
                              child: Text('Cash on delivery'),
                            ),
                            SizedBox(
                              width: screenWidth * 0.15,
                            ),
                            Radio(
                              value: 2,
                              groupValue: groupValue1,
                              onChanged: (newValue) =>
                                  setState(() => groupValue1 = newValue),
                              activeColor: primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //ADD CARD
            Padding(
              padding: const EdgeInsets.all(13),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddCardScreen()));
                },
                child: Container(
                  height: screenHeight * 0.085,
                  child: Card(
                      elevation: 5,
                      child: Center(
                          child: Text(
                        '+Add Card',
                        style: TextStyle(color: primaryColor),
                      ))),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: screenWidth,
              // height: screenHeight * 0.31,
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.05,
                      ),
                      child: Text(
                        'Saved Payments',
                        style: TextStyle(color: cartTextColor, fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Image.asset('assets/images/visa2.png'),
                          TextColumn(
                            screenWidth: screenWidth,
                            txt: 'Name',
                            txt1: '0010023145687',
                          ),
                          TextColumn(
                            screenWidth: screenWidth,
                            txt: '08/02/201',
                            txt1: '0023',
                          ),
                          SizedBox(
                            width: screenWidth * 0.07,
                          ),
                          Radio(
                              activeColor: primaryColor,
                              value: 0,
                              groupValue: groupValue2,
                              onChanged: (val) {
                                setState(() {
                                  groupValue2 = val;
                                });
                              })
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                      color: cartTextColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Image.asset('assets/images/visa2.png'),
                          TextColumn(
                            screenWidth: screenWidth,
                            txt: 'Name',
                            txt1: '0010023145687',
                          ),
                          TextColumn(
                            screenWidth: screenWidth,
                            txt: '08/02/201',
                            txt1: '0023',
                          ),
                          SizedBox(
                            width: screenWidth * 0.07,
                          ),
                          Radio(
                              activeColor: primaryColor,
                              value: 1,
                              groupValue: groupValue2,
                              onChanged: (val) {
                                setState(() {
                                  groupValue2 = val;
                                });
                              })
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                      color: cartTextColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Image.asset('assets/images/visa2.png'),
                          TextColumn(
                            screenWidth: screenWidth,
                            txt: 'Name',
                            txt1: '0010023145687',
                          ),
                          TextColumn(
                            screenWidth: screenWidth,
                            txt: '08/02/201',
                            txt1: '0023',
                          ),
                          SizedBox(
                            width: screenWidth * 0.07,
                          ),
                          Radio(
                              activeColor: primaryColor,
                              value: 2,
                              groupValue: groupValue2,
                              onChanged: (val) {
                                setState(() {
                                  groupValue2 = val;
                                });
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.028, bottom: screenHeight * 0.02),
              child: Container(
                color: Colors.white,
                width: screenWidth,
                // height: screenHeight * 0.19,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.02),
                        child: Text(
                          'Enter Promo Code',
                          style: boldTextStyle,
                        ),
                      ),
                      TFContainer(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: screenHeight * 0.06,
                            width: screenWidth * 0.3,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: primaryColor),
                            ),
                            child: Center(
                                child: Text(
                              'Apply',
                              style: TextStyle(color: primaryColor),
                            )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.028),
              child: Container(
                color: Colors.white,
                width: screenWidth,
                height: screenHeight * 0.3,
                child: Column(
                  children: [
                    PaymentColumn(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      subTotal: 999.toString(),
                      total: 999.toString(),
                      flatShippingRate: 999.toString(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.013),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MyButton(
                              height: screenHeight * 0.07,
                              // width: double.maxFinite,
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              borderColor: Colors.transparent,
                              innerColor: primaryColor,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OrderDetailsScreen()));
                              },
                            ),
                          ),
                          Expanded(
                            child: MyButton(
                              height: screenHeight * 0.07,
                              // width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      FontAwesomeIcons.apple,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Pay',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                ],
                              ),
                              borderColor: Colors.transparent,
                              innerColor: Colors.black,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PaymentScreen()));
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextColumn extends StatelessWidget {
  const TextColumn({
    Key key,
    @required this.screenWidth,
    this.txt,
    this.txt1,
  }) : super(key: key);

  final double screenWidth;
  final String txt;
  final String txt1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: screenWidth * 0.06, right: screenWidth * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(txt), Text(txt1)],
      ),
    );
  }
}
