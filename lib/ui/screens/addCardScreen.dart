import 'dart:convert';

import 'package:adva/bloc/payment_bloc/paymentCubit.dart';
import 'package:adva/data/model/payment.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCardScreen extends StatefulWidget {
  final User user;

  const AddCardScreen({Key key, this.user}) : super(key: key);
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  int _groupValue = 1;

  List<String> cards = ['Visa', 'Master', 'Mada'];
  String cardName = 'Visa';
  String number = '', exp = '', code = '', name = '';
  bool save = false;
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
          'Add Card',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Container(
            color: Colors.white,
            width: screenWidth,
            // height: screenHeight * 0.16,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method',
                    style: TextStyle(color: primaryColor, fontSize: 18),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.017, bottom: screenHeight * 0.01),
                    child: Container(
                      height: screenHeight * 0.08,
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              color: Colors.white,
              width: screenWidth,
              // height: screenHeight * 0.315,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Details',
                    style: TextStyle(color: primaryColor, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Card Name',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.grey,
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        color: Colors.white,
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down,
                            ),
                            iconSize: 42,
                            value: cardName,
                            underline: SizedBox(),
                            items: cards.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text('$value'),
                              );
                            }).toList(),
                            onChanged: (_) {
                              setState(() {
                                cardName = _;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Card Number',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: double.maxFinite,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      onChanged: (val) {
                        number = val;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Name on card',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: double.maxFinite,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      onChanged: (val) {
                        name = val;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Card Number',
                  //       style: TextStyle(fontSize: 14, color: Colors.black),
                  //     ),
                  //     Text(
                  //       'Card Number',
                  //       style: TextStyle(fontSize: 14, color: Colors.black),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Expiry date',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              child: TextField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                onChanged: (val) {
                                  exp = val;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            'Security Code',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              child: TextField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                onChanged: (val) {
                                  code = val;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: save,
                          activeColor: primaryColor,
                          onChanged: (bool newValue) {
                            setState(() {
                              save = newValue;
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
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: MyButton(
              height: 55,
              innerColor: Colors.white,
              borderColor: primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                    child: Text(
                  'Scan Card',
                  style: TextStyle(color: primaryColor),
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: MyButton(
              onPressed: () async {
                if (number != '' && code != '' && exp != '' && name != '') {
                  Payment payment = Payment();
                  payment.securityCode = code;
                  payment.cardNumber = number;
                  payment.expiryDate = exp;
                  payment.nameOnCard = name;
                  payment.customerId = widget.user.id;
                  if (save) {
                    bool added = await BlocProvider.of<PaymentCubit>(context)
                        .addPayment(payment);
                    if (added) {
                      showToast("Information saved", primaryColor);
                      Navigator.pop(context);
                    } else
                      showToast("Card not saved", primaryColor);
                  } else {
                    bool added = await BlocProvider.of<PaymentCubit>(context)
                        .addPayment(payment);
                    var sp = await SharedPreferences.getInstance();
                    sp.setString("tempo", json.encode(payment.toJson()));
                    showToast("Card saved Temporarily", primaryColor);
                    Navigator.pop(context);
                  }
                } else {
                  showToast("Please fill all fields", primaryColor);
                }
              },
              height: 55,
              innerColor: primaryColor,
              borderColor: Colors.transparent,
              child: Center(
                  child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              )),
            ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            txt,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: screenHeight * 0.06,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.always,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onSaved: (String value) {},
            ),
          ),
        ],
      ),
    );
  }
}
