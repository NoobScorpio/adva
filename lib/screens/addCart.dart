import 'package:adva/screens/orderDetailsScreen.dart';
import 'package:adva/utils/constants.dart';
import 'package:adva/utils/primaryButton.dart';
import 'package:adva/utils/tFContainer.dart';
import 'package:flutter/material.dart';

class AddCart extends StatefulWidget {
  @override
  _AddCartState createState() => _AddCartState();
}

class _AddCartState extends State<AddCart> {
  int _groupValue = 1;
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.12,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.035),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.2, top: screenHeight * 0.04),
          child: Text(
            'Add Cart',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Container(
            color: Colors.white,
            width: screenWidth,
            height: screenHeight * 0.16,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method',
                    style: TextStyle(color: cartTextColor, fontSize: 18),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.017, bottom: screenHeight * 0.01),
                    child: Container(
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(border: Border.all(width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Image.asset('assets/images/visa2.png'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 39),
                              child:
                                  Image.asset('assets/images/mastercard2.png'),
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
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.029,
          ),
          Container(
            color: Colors.white,
            width: screenWidth,
            height: screenHeight * 0.315,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Details',
                    style: TextStyle(color: cartTextColor, fontSize: 18),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.02, top: screenHeight * 0.015),
                    child: Text(
                      'Card Number',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  TFContainer(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailContainerRow(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          txt: 'Expiry Date'),
                      DetailContainerRow(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          txt: 'Security Code'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: checkBoxValue,
                          activeColor: Colors.black,
                          onChanged: (bool newValue) {
                            setState(() {
                              checkBoxValue = newValue;
                            });
                            Text('Remember me');
                          }),
                      Text(
                        'Save payment method',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
            child: Text(
              'Or',
              style: TextStyle(fontSize: 19, color: Colors.black),
            ),
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                border: Border.all(width: 0.05, color: Colors.black),
                color: Colors.white,
              ),
              child: Center(
                  child: Text(
                'Scan Card',
                // style: TextStyle(fontSize: 15),
              )),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.14,
          ),
          PrimaryButton(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            txt: 'Save',
            onpressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderDetailsScreen()));
            },
          ),
        ],
      ),
    );
  }
}

class DetailContainerRow extends StatelessWidget {
  const DetailContainerRow({
    Key key,
    @required this.screenWidth,
    @required this.screenHeight,
    this.txt,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.02),
              child: Text(
                txt,
                style: TextStyle(color: Colors.black),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TFContainer(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
