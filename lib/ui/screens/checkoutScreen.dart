import 'package:adva/paymentScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/paymentColumn.dart';
import 'package:adva/ui/utils/tFContainer.dart';
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
                          style: boldTextStyle,
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
                // height: screenHeight * 0.29,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          tileColor: Colors.white,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Address 1'),
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
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              Text(
                                'House No.1 , Sawabi street , Lower jinnahabad, Mandian, Abbottabad',
                                style: normalTextStyle,
                              ),
                            ],
                          ),
                          trailing: Icon(
                            Icons.check_circle,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          tileColor: Colors.white,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Address 1'),
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
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              Text(
                                'House No.1 , Sawabi street , Lower jinnahabad, Mandian, Abbottabad',
                                style: normalTextStyle,
                              ),
                            ],
                          ),
                          trailing: Icon(Icons.circle),
                        ),
                      ),
                      Divider(
                        color: cartTextColor,
                        endIndent: screenWidth * 0.05,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Material(
                  elevation: 4,
                  child: Container(
                    height: 60,
                    width: double.maxFinite,
                    color: primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.location_history,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              'Locate Me',
                              style: TextStyle(color: primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                // height: screenHeight * 0.26,
                width: screenWidth,
                color: Colors.white,
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
                      padding: const EdgeInsets.all(8.0),
                      child: MyButton(
                        height: 65,
                        width: screenWidth,
                        child: Text('Proceed to payments',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        borderColor: Colors.transparent,
                        innerColor: primaryColor,
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
