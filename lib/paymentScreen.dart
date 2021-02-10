import 'dart:ui';

import 'package:adva/screens/addCart.dart';
import 'package:adva/utils/constants.dart';
import 'package:adva/utils/paymentColumn.dart';
import 'package:adva/utils/roundDoneContainer.dart';
import 'package:adva/utils/tFContainer.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    int _groupValue = 1;

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
                                groupValue: _groupValue,
                                onChanged: (newValue) =>
                                    setState(() => _groupValue = newValue),
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
                              value: 0,
                              groupValue: _groupValue,
                              onChanged: (newValue) =>
                                  setState(() => _groupValue = newValue),
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
            Padding(
              padding: const EdgeInsets.all(13),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddCart()));
                },
                child: Container(
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(border: Border.all(width: 0.5)),
                  child: Center(child: Text('+Add Cart')),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: screenWidth,
              height: screenHeight * 0.305,
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
                    VisaSelectionRow(
                        screenHeight: screenHeight, screenWidth: screenWidth),
                    Divider(
                      thickness: 0.5,
                      color: cartTextColor,
                    ),
                    VisaUnSelectionRow(
                        screenHeight: screenHeight, screenWidth: screenWidth),
                    Divider(
                      thickness: 0.5,
                      color: cartTextColor,
                    ),
                    VisaUnSelectionRow(
                        screenHeight: screenHeight, screenWidth: screenWidth),
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
                        child: Text('Enter Promo Code'),
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
                            height: screenHeight * 0.053,
                            width: screenWidth * 0.25,
                            decoration:
                                BoxDecoration(border: Border.all(width: 0.5)),
                            child: Center(child: Text('Apply')),
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
                height: screenHeight * 0.23,
                child: Column(
                  children: [
                    PaymentColumn(
                        screenHeight: screenHeight, screenWidth: screenWidth),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.013),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NextPayButton(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            clr: primaryColor,
                            txt: 'Next',
                          ),
                          NextPayButton(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            clr: Colors.black,
                            image: Image.asset('assets/images/apple.png'),
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

class NextPayButton extends StatelessWidget {
  const NextPayButton({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
    this.clr,
    this.txt,
    this.image,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final Color clr;
  final String txt;
  final image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.05,
      width: screenWidth * 0.435,
      child: FlatButton(
        color: clr,
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null) image,
            if (txt != null)
              Text(
                txt,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
          ],
        ),
      ),
    );
  }
}

class VisaUnSelectionRow extends StatelessWidget {
  const VisaUnSelectionRow({
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
        top: screenHeight * 0.013,
        left: screenWidth * 0.05,
      ),
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
          Container(
            height: screenHeight * 0.018,
            width: screenWidth * 0.035,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(30)),
          ),
        ],
      ),
    );
  }
}

class VisaSelectionRow extends StatelessWidget {
  const VisaSelectionRow({
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
        top: screenHeight * 0.022,
        left: screenWidth * 0.05,
      ),
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
          RoundDoneContainer(),
        ],
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
