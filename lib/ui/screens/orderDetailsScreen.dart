import 'package:adva/bloc/order_bloc/orderCubit.dart';
import 'package:adva/bloc/order_bloc/orderState.dart';
import 'package:adva/data/model/cart.dart';
import 'package:adva/data/model/orderDetail.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/paymentColumn.dart';
import 'package:adva/ui/utils/statesUi.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int oid, cid;

  const OrderDetailsScreen({Key key, this.oid, this.cid}) : super(key: key);
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<OrderCubit>(context)
        .getOrderDetails(widget.cid, widget.oid);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Summary',
                style: TextStyle(color: primaryColor),
              ),
              //ORDER DETAILS
              Container(
                  width: screenWidth,
                  child: BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
                      if (state is OrderInitialState)
                        return buildLoading();
                      else if (state is OrderLoadingState)
                        return buildLoading();
                      else if (state is OrderLoadedState) {
                        return buildLoading();
                      } else if (state is OrderDetailsLoadedState) {
                        if (state.orderDetail != null)
                          return getOrderSummary(
                              orderDetail: state.orderDetail);
                        else
                          return buildLoading();
                      } else if (state is OrderErrorState)
                        return buildErrorUi("No items in this order");
                      else
                        return buildErrorUi("No items in this order");
                    },
                  )),

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
                        PaymentColumn(),
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

  Widget getOrderSummary({OrderDetail orderDetail}) {
    if (orderDetail != null) {
      List<Widget> widgets = [];
      for (Cart cart in orderDetail.cart) {
        widgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 60,
              width: 70,
              child: Card(
                color: Color(0xFFE6E6E6),
                elevation: 5,
                child: cart.product.productimages.length > 0
                    ? FittedBox(
                        fit: BoxFit.cover,
                        child: Image.network(
                            cart.product.productimages[0].pictureReference))
                    : Center(
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
                  Text('${cart.product.productName}'),
                  Text('${cart.product.category.categoryName} / ${cart.size}',
                      style: TextStyle(
                        color: cartTextColor,
                      ))
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Sar ${cart.price}',
                    style: TextStyle(
                      color: cartTextColor,
                    )),
                Text('Quantity: ${cart.quantity}',
                    style: TextStyle(
                      color: cartTextColor,
                    ))
              ],
            ),
          ],
        ));
      }
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
    }

    return Center(
      child: Text("No item in this order"),
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
