import 'dart:ui';

import 'package:adva/bloc/payment_bloc/paymentState.dart';
import 'package:adva/data/model/checkOut.dart';
import 'package:adva/data/model/payment.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/screens/addCardScreen.dart';
import 'package:adva/ui/screens/orderDetailsScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/paymentColumn.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:adva/ui/utils/tFContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final User user;
  final CheckOutInfo checkout;
  final dynamic total, subTotal;
  const PaymentScreen(
      {Key key, this.user, this.checkout, this.total, this.subTotal})
      : super(key: key);
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Payments',
          style: TextStyle(
            color: Colors.black,
            // fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Container(
              color: Colors.white,
              width: screenWidth,
              height: screenHeight * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method',
                    style: TextStyle(color: cartTextColor),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(border: Border.all(width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Card Payment'),
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset('assets/images/visa.png'),
                                Image.asset('assets/images/mCard.png'),
                                Image.asset('assets/images/mada.png'),
                              ],
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(border: Border.all(width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Cash on Delivery'),
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset('assets/images/cash.png'),
                              ],
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
                  ),
                ],
              ),
            ),
            //ADD CARD
            if (groupValue1 == 1)
              Padding(
                padding: const EdgeInsets.all(13),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             AddCardScreen(user: widget.user)));
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
            //SAVED PAYMENTS
            if (groupValue1 == 1)
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
                      // BlocConsumer(
                      //   listener: (context, state) {},
                      //   builder: (context, state) {
                      //     if (state is PaymentInitialState)
                      //       return buildLoading();
                      //     if (state is PaymentLoadingState)
                      //       return buildLoading();
                      //     if (state is PaymentLoadedState) {
                      //       if (state.payments != null &&
                      //           state.payments.length != 0) {
                      //         groupValue2 = state.payments[0].id;
                      //         return paymentWidgets(payments: state.payments);
                      //       } else
                      //         return paymentWidgets(payments: []);
                      //     }
                      //     if (state is PaymentAddState) {
                      //       if (state.payments != null &&
                      //           state.payments.length != 0) {
                      //         groupValue2 = state.payments[0].id;
                      //         return paymentWidgets(payments: state.payments);
                      //       } else
                      //         return paymentWidgets(payments: []);
                      //     }
                      //     if (state is PaymentDeleteState) {
                      //       if (state.payments != null &&
                      //           state.payments.length != 0) {
                      //         groupValue2 = state.payments[0].id;
                      //         return paymentWidgets(payments: state.payments);
                      //       } else
                      //         return paymentWidgets(payments: []);
                      //     } else
                      //       return paymentWidgets(payments: []);
                      //   },
                      // )
                    ],
                  ),
                ),
              ),
            //PROMO
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
            //NEXT PAYMENT
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.028),
              child: Container(
                color: Colors.white,
                width: screenWidth,
                height: screenHeight * 0.3,
                child: Column(
                  children: [
                    PaymentColumn(
                      subTotal: widget.subTotal.toString(),
                      total: (widget.total + 10).toString(),
                      flatShippingRate: 10.toString(),
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
                                CheckOutInfo checkOutInfo = widget.checkout;
                                checkOutInfo.paymentMethod = groupValue1 == 1
                                    ? "Card Payment"
                                    : "Cash on delivery";
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OrderDetailsScreen(
                                                personal: checkOutInfo,
                                                cart: true,
                                                total: widget.total,
                                                subTotal: widget.subTotal,
                                                user: widget.user)));
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => PaymentScreen()));
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

  Widget paymentWidgets({List<Payment> payments}) {
    if (payments.length > 0) {
      List<Widget> widgets = [];
      List<String> cards = ['Visa', 'Master', 'Mada'];
      for (Payment payment in payments) {
        String image = payment.cardBrand == cards[0]
            ? 'visa'
            : (payment.cardBrand == cards[1] ? 'mCard' : 'mada');
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 30,
                width: 50,
                child: Image.asset("/assets/images/$image.png"),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Address ${payment.nameOnCard}'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${payment.cardNumber}',
                    style: normalTextStyle,
                    maxLines: 3,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${payment.expiryDate}'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${payment.securityCode}.',
                    style: normalTextStyle,
                    maxLines: 3,
                  )
                ],
              ),
              Radio(
                value: payment.id,
                groupValue: groupValue2,
                activeColor: primaryColor,
                onChanged: (val) {
                  setState(() {
                    groupValue2 = val;
                  });
                },
              ),
            ],
          ),
        ));
      }
      return Container(
        height: widgets.length == 1 ? 120 : (widgets.length == 2 ? 220 : (300)),
        child: ListView(
          children: widgets,
        ),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('You have no payments saved.'),
      ),
    );
  }
}
