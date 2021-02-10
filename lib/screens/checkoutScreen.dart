import 'package:adva/paymentScreen.dart';
import 'package:adva/utils/constants.dart';
import 'package:adva/utils/paymentColumn.dart';
import 'package:adva/utils/roundDoneContainer.dart';
import 'package:adva/utils/tFContainer.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool checkBoxValue = false;

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
            'Check Out',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.015),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.46,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.015,
                      right: screenWidth * 0.01,
                      top: screenHeight * 0.015),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Personal Information',
                          style: TextStyle(color: cartTextColor),
                        ),
                      ),
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight * 0.01,
                                  left: screenWidth * 0.024),
                              child: TFText(
                                txt: 'Full Name',
                              ),
                            ),
                            TFContainer(
                                screenHeight: screenHeight,
                                screenWidth: screenWidth),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight * 0.015,
                                  left: screenWidth * 0.024),
                              child: TFText(
                                txt: 'E-mail address',
                              ),
                            ),
                            TFContainer(
                                screenHeight: screenHeight,
                                screenWidth: screenWidth),
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
                                Text('Keep me up date with exclusive offers'),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight * 0.015,
                                  left: screenWidth * 0.024),
                              child: TFText(
                                txt: 'Phone No.',
                              ),
                            ),
                            TFContainer(
                                screenHeight: screenHeight,
                                screenWidth: screenWidth),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                height: screenHeight * 0.29,
                width: screenWidth,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.017,
                    left: screenWidth * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TFText(
                        txt: 'Shipping Address',
                      ),
                      Row(
                        children: [
                          Text('Address 1'),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          MaterialButton(
                            height: screenHeight * 0.03,
                            minWidth: screenWidth * 0.01,
                            color: checkoutButtonColor,
                            onPressed: () {},
                            child: Text(
                              '(Home)',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'House No.1 , Sawabi street , Lower jinnahabad,',
                            style:
                                TextStyle(color: cartTextColor, fontSize: 12),
                          ),
                          SizedBox(
                            width: screenWidth * 0.15,
                          ),
                          RoundDoneContainer(),
                        ],
                      ),
                      Text(
                        'Mandiyan, Abbottabad',
                        style: TextStyle(color: cartTextColor, fontSize: 12),
                      ),
                      Divider(
                        color: cartTextColor,
                        endIndent: screenWidth * 0.05,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          Text('Address 1'),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          MaterialButton(
                            height: screenHeight * 0.03,
                            minWidth: screenWidth * 0.01,
                            color: checkoutButtonColor,
                            onPressed: () {},
                            child: Text(
                              '(Office)',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'House No.1 , Sawabi street , Lower jinnahabad,',
                            style:
                                TextStyle(color: cartTextColor, fontSize: 12),
                          ),
                          SizedBox(
                            width: screenWidth * 0.15,
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
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                ),
                child: Container(
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.92,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_history),
                      Text('Locate Me'),
                    ],
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.25,
                width: screenWidth,
                color: Colors.white,
                child: Column(
                  children: [
                    PaymentColumn(
                        screenHeight: screenHeight, screenWidth: screenWidth),
                    Container(
                      width: screenWidth,
                      height: screenHeight * 0.084,
                      child: Padding(
                        padding: const EdgeInsets.all(11),
                        child: MaterialButton(
                          color: primaryColor,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaymentScreen()));
                          },
                          child: Text('Proceed to payments',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TFText extends StatelessWidget {
  TFText({this.txt});

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(color: Colors.black),
    );
  }
}
