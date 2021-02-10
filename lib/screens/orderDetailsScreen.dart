import 'package:adva/screens/bottomNavBar.dart';
import 'package:adva/utils/constants.dart';
import 'package:adva/utils/generalContainer.dart';
import 'package:adva/utils/paymentColumn.dart';
import 'package:adva/utils/primaryButton.dart';
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
        toolbarHeight: screenHeight * 0.11,
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
              left: screenWidth * 0.17, top: screenHeight * 0.04),
          child: Text(
            'Order Details',
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              child: GeneralContainer(
                screenWidth: screenWidth,
                screenHeight: screenHeight * 0.31,
                column: Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.015,
                      left: screenWidth * 0.04,
                      right: 0.04),
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
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: GeneralContainer(
                screenWidth: screenWidth,
                screenHeight: screenHeight * 0.2,
                column: Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.015,
                      left: screenWidth * 0.04,
                      right: 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralText(
                        txt: 'Personal Information',
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: GeneralContainer(
                screenWidth: screenWidth,
                screenHeight: screenHeight * 0.27,
                column: Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.015,
                      left: screenWidth * 0.04,
                      right: 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralText(
                        txt: 'Shipping',
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
                    ],
                  ),
                ),
              ),
            ),
            GeneralContainer(
              screenHeight: screenHeight * 0.24,
              screenWidth: screenWidth,
              column: Column(
                children: [
                  PaymentColumn(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  PrimaryButton(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    txt: 'Next',
                    onpressed: () {
                      showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.black,
                              actions: [
                                Container(
                                  height: screenHeight * 0.2,
                                  width: screenWidth,
                                  child: Column(
                                    children: [
                                      DialogText(text: 'Success'),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
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
                                          text: 'Your order is on your way'),
                                      SizedBox(height: screenHeight * 0.04),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomNavBar()));
                                        },
                                        child: Container(
                                          height: screenHeight * 0.05,
                                          width: screenWidth,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                          ),
                                          child: Center(
                                            child:
                                                DialogText(text: 'Go to Home'),
                                          ),
                                        ),
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
            )
          ],
        ),
      ),
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
      children: [
        Container(
          height: screenHeight * 0.067,
          width: screenWidth * 0.15,
          child: Card(
            color: Color(0xFFE6E6E6),
            elevation: 20,
            child: Center(child: Icon(Icons.image)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.06, right: screenWidth * 0.06),
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
        Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.2, right: screenWidth * 0.06),
          child: Column(
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
        ),
      ],
    );
  }
}
