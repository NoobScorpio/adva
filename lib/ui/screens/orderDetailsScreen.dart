import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/paymentColumn.dart';

import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        title: Text(
          'Order Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              //ORDER DETAILS
              Container(
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeneralText(
                      txt: 'Summary',
                    ),
                    SummaryRow(
                        screenHeight: screenHeight, screenWidth: screenWidth),
                    Divider(
                      thickness: 0.5,
                      endIndent: 26,
                    ),
                    SummaryRow(
                        screenHeight: screenHeight, screenWidth: screenWidth),
                    Divider(
                      thickness: 0.5,
                      endIndent: 26,
                    ),
                    SummaryRow(
                        screenHeight: screenHeight, screenWidth: screenWidth),
                  ],
                ),
              ),

              //PERSONAL INFORMATION
              Container(
                width: screenWidth,
                // height: screenHeight * 0.2,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Information',
                          style: TextStyle(color: primaryColor),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Text('Full Name'),
                        Text(
                          'Demo User Name',
                          style: TextStyle(color: cartTextColor),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('E-mail address'),
                                Text(
                                  'Demo email address',
                                  style: TextStyle(color: cartTextColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: screenWidth * 0.3,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Phone No.'),
                                Text(
                                  '0992406725',
                                  style: TextStyle(color: cartTextColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //SHIPPING PAYMENT
              Container(
                width: screenWidth,
                // height: screenHeight * 0.27,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shipping',
                          style: TextStyle(color: primaryColor),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Text('Address'),
                        Text(
                          'Demo address, Location, City, Postal Code',
                          style: TextStyle(color: cartTextColor),
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Country'),
                                Text(
                                  'Saudia Arabia',
                                  style: TextStyle(color: cartTextColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: screenWidth * 0.3,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('City'),
                                Text(
                                  'Riyadh',
                                  style: TextStyle(color: cartTextColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Text('Postal Code'),
                        Text(
                          '02215',
                          style: TextStyle(color: cartTextColor),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Text(
                          'Payment',
                          style: TextStyle(color: primaryColor),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Text('Payment method'),
                        Text(
                          'Cash on Delivery',
                          style: TextStyle(color: cartTextColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //RATES
              Container(
                // height: 200,
                width: screenWidth,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Column(
                      children: [
                        PaymentColumn(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        MyButton(
                          width: double.maxFinite,
                          height: 60,
                          innerColor: primaryColor,
                          borderColor: Colors.transparent,
                          child: Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.black87,
                                    actions: [
                                      Container(
                                        // height: screenHeight * 0.2,
                                        width: screenWidth,
                                        child: Column(
                                          children: [
                                            DialogText(text: 'Success'),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Container(
                                                height: screenHeight * 0.033,
                                                width: screenWidth * 0.065,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.white,
                                                ),
                                                child: Icon(
                                                  Icons.done,
                                                  color: Colors.black,
                                                  size: 25,
                                                ),
                                              ),
                                            ),
                                            DialogText(
                                                text:
                                                    'Your order is on your way'),
                                            SizedBox(
                                                height: screenHeight * 0.04),
                                            MyButton(
                                              height: 50,
                                              width: double.maxFinite,
                                              onPressed: () {
                                                Navigator.of(context).popUntil(
                                                    (route) => route.isFirst);
                                              },
                                              child: Text(
                                                'Go to Home',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              innerColor: primaryColor,
                                              borderColor: Colors.transparent,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class DialogText extends StatelessWidget {
  const DialogText({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 15),
    );
  }
}

class GeneralText extends StatelessWidget {
  const GeneralText({
    Key key,
    this.txt,
  }) : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(color: primaryColor),
    );
  }
}

class SummaryRow extends StatelessWidget {
  const SummaryRow({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 60,
          width: 70,
          child: Card(
            color: Color(0xFFE6E6E6),
            elevation: 5,
            child: Center(
                child: Icon(
              Icons.photo_library_outlined,
              color: Colors.grey,
            )),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Product Name'),
              Text('Category / Size',
                  style: TextStyle(
                    color: cartTextColor,
                  ))
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Sar 999',
                style: TextStyle(
                  color: cartTextColor,
                )),
            Text('Quantity: 2',
                style: TextStyle(
                  color: cartTextColor,
                ))
          ],
        ),
      ],
    );
  }
}
