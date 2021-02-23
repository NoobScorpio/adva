import 'package:adva/bloc/cart_bloc/cartCubit.dart';
import 'package:adva/bloc/cart_bloc/cartState.dart';
import 'package:adva/bloc/order_bloc/orderCubit.dart';
import 'package:adva/bloc/order_bloc/orderState.dart';
import 'package:adva/data/model/cart.dart';
import 'package:adva/data/model/cartItem.dart';
import 'package:adva/data/model/checkOut.dart';
import 'package:adva/data/model/orderDetail.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/screens/orderReturnScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/paymentColumn.dart';
import 'package:adva/ui/utils/statesUi.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int oid, cid;
  final bool cart;
  final User user;
  final CheckOutInfo personal;
  final dynamic total, subTotal;
  const OrderDetailsScreen(
      {Key key,
      this.oid,
      this.cid,
      this.cart,
      this.user,
      this.personal,
      this.total,
      this.subTotal})
      : super(key: key);
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!(widget.cart))
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Summary',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                    //ORDER DETAILS
                    if (!(widget.cart))
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
                                if (state.orderDetail != null) {
                                  print(
                                      "INSIDE ORDER DETAIL ${state.orderDetail.cart.length}");
                                  return getOrderSummary(
                                      orderDetail: state.orderDetail);
                                } else
                                  return buildLoading();
                              } else if (state is OrderErrorState)
                                return buildErrorUi("No items in this order");
                              else
                                return buildErrorUi("No items in this order");
                            },
                          )),
                    if (widget.cart)
                      Container(
                          width: screenWidth,
                          child: BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              if (state is CartInitialState)
                                return buildLoading();
                              else if (state is CartLoadingState)
                                return buildLoading();
                              else if (state is CartLoadedState) {
                                if (state.cartItems != null &&
                                    state.cartItems.length > 0) {
                                  return getCartSummary(
                                      cartItems: state.cartItems);
                                } else
                                  return buildLoading();
                              } else if (state is CartErrorState)
                                return buildErrorUi("No items in this order");
                              else
                                return buildErrorUi("No items in this order");
                            },
                          )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Personal Information',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                    //PERSONAL INFORMATION
                    if (!(widget.cart))
                      BlocBuilder<OrderCubit, OrderState>(
                        builder: (context, state) {
                          if (state is OrderInitialState)
                            return buildLoading();
                          else if (state is OrderLoadingState)
                            return buildLoading();
                          else if (state is OrderLoadedState) {
                            return buildLoading();
                          } else if (state is OrderDetailsLoadedState) {
                            if (state.orderDetail != null) {
                              // print(
                              //     "INSIDE ORDER DETAIL ${state.orderDetail.cart.length}");
                              return getPersonalInfo(
                                  orderDetail: state.orderDetail);
                            } else
                              return buildLoading();
                          } else if (state is OrderErrorState)
                            return buildErrorUi("No personal info available");
                          else
                            return buildErrorUi("No personal info available");
                        },
                      ),
                    if (widget.cart) getPersonalCartInfo(),
                    //SHIPPING PAYMENT
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Shipping',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                    if (!(widget.cart))
                      BlocBuilder<OrderCubit, OrderState>(
                        builder: (context, state) {
                          if (state is OrderInitialState)
                            return buildLoading();
                          else if (state is OrderLoadingState)
                            return buildLoading();
                          else if (state is OrderLoadedState) {
                            return buildLoading();
                          } else if (state is OrderDetailsLoadedState) {
                            if (state.orderDetail != null) {
                              // print(
                              //     "INSIDE ORDER DETAIL ${state.orderDetail.cart.length}");
                              return getShippingAndRate(
                                  orderDetail: state.orderDetail);
                            } else
                              return buildLoading();
                          } else if (state is OrderErrorState)
                            return buildErrorUi(
                                "No shipping & pricing info available");
                          else
                            return buildErrorUi(
                                "No shipping & pricing info available");
                        },
                      ),
                    if (widget.cart)
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          if (state is CartInitialState)
                            return buildLoading();
                          else if (state is CartLoadingState)
                            return buildLoading();
                          else if (state is CartLoadedState) {
                            if (state.cartItems != null) {
                              return getCartShippingAndRate();
                            } else
                              return buildLoading();
                          } else if (state is CartErrorState)
                            return buildErrorUi(
                                "No shipping & pricing info available");
                          else
                            return buildErrorUi(
                                "No shipping & pricing info available");
                        },
                      ),
                  ],
                ),
              ]),
            ),
            //BUTTON
            if (widget.cart)
              Container(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Column(
                      children: [
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
                                            Center(
                                              child: Text('Success'),
                                            ),
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
                                            Text('Your order is on your way'),
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
              ),
          ],
        ),
      ),
    );
  }

  Widget getCartSummary({List<CartItem> cartItems}) {
    if (cartItems != null && cartItems.length > 0) {
      List<Widget> widgets = [];
      for (CartItem cart in cartItems) {
        widgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 60,
              width: 70,
              child: Card(
                color: Color(0xFFE6E6E6),
                elevation: 5,
                child: cart.image != null
                    ? FittedBox(
                        fit: BoxFit.cover, child: Image.network(cart.image))
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
                  Text('${cart.pName ?? ""}'),
                  Text(
                      '${cart != null ? cart.category : "No Category"} / ${cart.size == "" || cart.size == null ? "No Size" : cart.size}',
                      style: TextStyle(
                        color: cartTextColor,
                      ))
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Sar ${cart.price ?? 0.0}',
                    style: TextStyle(
                      color: cartTextColor,
                    )),
                Text('Quantity: ${cart.qty ?? 1}',
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

  Widget getOrderSummary({OrderDetail orderDetail}) {
    if (orderDetail != null && orderDetail.cart.length > 0) {
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
                  Text(
                      '${cart.product.category != null ? cart.product.category.categoryName : "No Category"} / ${cart.size ?? "No Size"}',
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

  Widget getPersonalInfo({OrderDetail orderDetail}) {
    if (orderDetail != null) {
      return Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text('Full Name'),
                Text(
                  '${orderDetail.firstName ?? "Unknown"} ${orderDetail.lastName ?? ""}',
                  style: TextStyle(color: cartTextColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('E-mail address'),
                        Text(
                          '${orderDetail.email ?? "no email"}',
                          style: TextStyle(color: cartTextColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone No.'),
                        Text(
                          '${orderDetail.phone ?? "no phone"}',
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
      );
    }
    return Center(
      child: Text("No personal information available"),
    );
  }

  Widget getPersonalCartInfo() {
    if (widget.personal != null) {
      return Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text('Full Name'),
                Text(
                  '${widget.personal.name ?? ""}',
                  style: TextStyle(color: cartTextColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('E-mail address'),
                        Text(
                          '${widget.personal.email ?? "no email"}',
                          style: TextStyle(color: cartTextColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone No.'),
                        Text(
                          '${widget.personal.phone ?? "no phone"}',
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
      );
    }
    return Center(
      child: Text("No personal information available"),
    );
  }

  Widget getShippingAndRate({OrderDetail orderDetail}) {
    if (orderDetail != null) {
      dynamic subTotal;
      dynamic total;
      if (orderDetail.cart.length > 0) {
        subTotal = 0.0;
        total = 0.0;
        for (Cart cart in orderDetail.cart) {
          subTotal += cart.subTotal;
          total += cart.total;
        }
      }

      return Container(
        child: Column(
          children: [
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text('Address'),
                    Text(
                      '${orderDetail.address ?? "No address"}',
                      style: TextStyle(color: cartTextColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Country'),
                            Text(
                              '${orderDetail.country ?? "No country"}',
                              style: TextStyle(color: cartTextColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('City'),
                            Text(
                              '${orderDetail.city ?? "No city"}',
                              style: TextStyle(color: cartTextColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Postal Code'),
                    Text(
                      '${orderDetail.postalCode ?? "No postal code"}',
                      style: TextStyle(color: cartTextColor),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Payment',
                style: TextStyle(color: primaryColor),
              ),
            ),
            Card(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text('Payment method'),
                  Text(
                    '${orderDetail.paymentMethod ?? "No selected"}',
                    style: TextStyle(color: cartTextColor),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  PaymentColumn(
                    total: total != null
                        ? total.toString()
                        : orderDetail.total.toString(),
                    flatShippingRate: '10',
                    subTotal: subTotal != null
                        ? subTotal.toString()
                        : orderDetail.total.toString(),
                  )
                ],
              ),
            )),
            if (orderDetail.cart.length > 0)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => OrderReturnScreen(
                                user: widget.user,
                                orderDetail: orderDetail,
                              )));
                },
                child: Center(
                  child: Text(
                    'Return Order',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                        decoration: TextDecoration.underline),
                  ),
                ),
              )
          ],
        ),
      );
    }
    return Center(
      child: Text("No shipping & pricing information available"),
    );
  }

  Widget getCartShippingAndRate() {
    if (widget.personal != null) {
      return Container(
        child: Column(
          children: [
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text('Address'),
                    Text(
                      '${widget.personal.address ?? "No address"}',
                      style: TextStyle(color: cartTextColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Country'),
                            Text(
                              '${widget.personal.country ?? "No country"}',
                              style: TextStyle(color: cartTextColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('City'),
                            Text(
                              '${widget.personal.city ?? "No city"}',
                              style: TextStyle(color: cartTextColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Postal Code'),
                    Text(
                      '${widget.personal.postal ?? "No postal code"}',
                      style: TextStyle(color: cartTextColor),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Payment',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Payment method'),
                    Text(
                      '${widget.personal.paymentMethod ?? "No selected"}',
                      style: TextStyle(color: cartTextColor),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    PaymentColumn(
                      total: (widget.total + 10).toString(),
                      flatShippingRate: '10',
                      subTotal: widget.subTotal.toString(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Center(
      child: Text("No shipping & pricing information available"),
    );
  }
}
