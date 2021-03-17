import 'package:adva/bloc/cart_bloc/cartCubit.dart';
import 'package:adva/bloc/cart_bloc/cartState.dart';
import 'package:adva/bloc/order_bloc/orderCubit.dart';
import 'package:adva/bloc/order_bloc/orderState.dart';
import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/data/model/cart.dart';
import 'package:adva/data/model/cartItem.dart';
import 'package:adva/data/model/checkOut.dart';
import 'package:adva/data/model/order.dart';
import 'package:adva/data/model/orderDetail.dart';
import 'package:adva/data/model/orderProduct.dart';
import 'package:adva/data/model/product.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/repository/cartRepo.dart';
import 'package:adva/data/repository/orderRepo.dart';
import 'package:adva/ui/screens/cardPaymentScreen.dart';
import 'package:adva/ui/screens/orderReturnScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/paymentColumn.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int oid, cid;
  final bool cart;
  final User user;
  final promoCode, discountCode;
  final int pointsDiscount;
  final CheckOutInfo personal;
  final dynamic total, subTotal, shipRate;
  const OrderDetailsScreen(
      {Key key,
      this.oid,
      this.cid,
      this.cart,
      this.user,
      this.personal,
      this.total,
      this.subTotal,
      this.shipRate,
      this.promoCode,
      this.discountCode,
      this.pointsDiscount})
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
    bool english = context.locale == Locale('en', '');
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
        ).tr(),
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
                      alignment:
                          english ? Alignment.topLeft : Alignment.topRight,
                      child: Text(
                        'Summary',
                        style: TextStyle(color: primaryColor),
                      ).tr(),
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
                                      orderDetail: state.orderDetail,
                                      english: english);
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
                      alignment: context.locale == Locale('en', '')
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: Text(
                        'Personal Information',
                        style: TextStyle(color: primaryColor),
                      ).tr(),
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
                      alignment: context.locale == Locale('en', '')
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: Text(
                        'Shipping',
                        style: TextStyle(color: primaryColor),
                      ).tr(),
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
                            'Confirm',
                            style: TextStyle(color: Colors.white),
                          ).tr(),
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (_) => Center(
                                child: Image.asset(
                                  'assets/images/loader.gif',
                                  scale: 3,
                                ),
                              ),
                            );
                            List<OrderProduct> products = [];
                            List<CartItem> cartItems =
                                await CartRepositoryImpl().getItems();
                            for (var item in cartItems) {
                              products.add(OrderProduct(
                                  id: item.pid,
                                  price: item.price,
                                  newQuantity: item.qty));
                            }
                            print("@PAYMENT ${widget.personal.paymentMethod}");
                            Order order = Order(
                                customerId: widget.user.id,
                                total: widget.total,
                                email: widget.user.email,
                                phone: widget.user.phone,
                                addressId: widget.personal.addressId,
                                products: products,
                                paymentType: widget.personal.paymentMethod,
                                promoCode: widget.promoCode,
                                discountCode: widget.discountCode,
                                pointsDiscount: widget.pointsDiscount ?? 0);
                            print(
                                "@ ORDER BOIS ${order.customerId} ${order.promoCode} ${order.discountCode} ${order.pointsDiscount}");
                            if (widget.personal.paymentMethod ==
                                'CashonDelivery') {
                              int ordered = await OrderRepositoryImpl()
                                  .createOrder(order: order);
                              if (ordered != null) {
                                User user = widget.user;
                                user.points = ordered;
                                print("@POINTS ${user.points}");
                                bool updated =
                                    await BlocProvider.of<UserCubit>(context)
                                        .updateLocalInfo(user);
                                if (updated) {
                                  Navigator.pop(context);
                                  await BlocProvider.of<CartCubit>(context)
                                      .emptyCart();
                                  successDialog(
                                      screenHeight: screenHeight,
                                      screenWidth: screenWidth);
                                }
                              } else {
                                Navigator.pop(context);
                                showToast(
                                    "Please try again later", primaryColor);
                              }
                            } else {
                              String id = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CardPaymentScreen(
                                            total: widget.total,
                                            id: widget.user.id,
                                          )));

                              if (id != null && id != '') {
                                order.id = id;
                                bool confirmed = await OrderRepositoryImpl()
                                    .confirmOrder(order: order);

                                if (confirmed != null) {
                                  Navigator.pop(context);
                                  await BlocProvider.of<CartCubit>(context)
                                      .emptyCart();
                                  successDialog(
                                      screenHeight: screenHeight,
                                      screenWidth: screenWidth);
                                } else {
                                  Navigator.pop(context);
                                  showToast(
                                      "Please try again later", primaryColor);
                                }
                              }
                            }
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

  successDialog({screenWidth, screenHeight}) {
    return showDialog<void>(
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
                      child: Text(
                        'Success',
                        style: TextStyle(color: Colors.white),
                      ).tr(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: screenHeight * 0.033,
                        width: screenWidth * 0.065,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.done,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ),
                    Text(
                      'Your order is on your way',
                      style: TextStyle(color: Colors.white),
                    ).tr(),
                    SizedBox(height: screenHeight * 0.04),
                    MyButton(
                      height: 50,
                      width: double.maxFinite,
                      onPressed: () {
                        int count = 0;
                        Navigator.popUntil(context, (route) {
                          return count++ == 5;
                        });
                      },
                      child: Text(
                        'Go to Home',
                        style: TextStyle(color: Colors.white),
                      ).tr(),
                      innerColor: primaryColor,
                      borderColor: Colors.transparent,
                    )
                  ],
                ),
              ),
            ],
          );
        });
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
                  Text('${cart.pName ?? ""}').tr(),
                  Text('${cart != null ? (cart.category) : "No Category"}',
                      style: TextStyle(
                        color: cartTextColor,
                      )).tr()
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Sar ${cart.price ?? 0.0}',
                    style: TextStyle(
                      color: cartTextColor,
                    )).tr(),
                Text('Quantity: ${cart.qty ?? 1}',
                    style: TextStyle(
                      color: cartTextColor,
                    )).tr()
              ],
            ),
          ],
        ));
      }
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
    }

    return Center(
      child: Text("No item in this order").tr(),
    );
  }

  Widget getOrderSummary({OrderDetail orderDetail, bool english}) {
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
                  Text(
                      '${english ? cart.product.productName : cart.product.productArabicName}'),
                  Text(
                      '${cart.product.category != null ? (english ? cart.product.category.categoryName : cart.product.category.categoryArabicName) : "No Category".tr()}',
                      style: TextStyle(
                        color: cartTextColor,
                      )).tr()
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('SAR'.tr() + ' ${cart.price}',
                    style: TextStyle(
                      color: cartTextColor,
                    )),
                Text('Quantity'.tr() + ': ${cart.quantity}',
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
      child: Text("No item in this order").tr(),
    );
  }

  Widget getPersonalInfo({OrderDetail orderDetail, bool english}) {
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
                Text('Full Name').tr(),
                Text(
                  '${orderDetail.firstName ?? "Unknown".tr()} ${orderDetail.lastName ?? ""}',
                  style: TextStyle(color: cartTextColor),
                ).tr(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('E-mail address').tr(),
                        Text(
                          '${orderDetail.email ?? "No email".tr()}',
                          style: TextStyle(color: cartTextColor),
                        ).tr(),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone No.').tr(),
                        Text(
                          '${orderDetail.phone ?? "No phone"}',
                          style: TextStyle(color: cartTextColor),
                        ).tr(),
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
      child: Text("No personal information available").tr(),
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
                Text('Full Name').tr(),
                Text(
                  '${widget.personal.name ?? ""}',
                  style: TextStyle(color: cartTextColor),
                ).tr(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('E-mail address').tr(),
                        Text(
                          '${widget.personal.email ?? "No email"}',
                          style: TextStyle(color: cartTextColor),
                        ).tr(),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone No.').tr(),
                        Text(
                          '${widget.personal.phone ?? "No phone"}',
                          style: TextStyle(color: cartTextColor),
                        ).tr(),
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
      child: Text("No personal information available").tr(),
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
                    Text('Address').tr(),
                    Text(
                      '${orderDetail.address ?? "No address"}',
                      style: TextStyle(color: cartTextColor),
                    ).tr(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Country').tr(),
                            Text(
                              '${orderDetail.country ?? "No country"}',
                              style: TextStyle(color: cartTextColor),
                            ).tr(),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('City').tr(),
                            Text(
                              '${orderDetail.city ?? "No city"}',
                              style: TextStyle(color: cartTextColor),
                            ).tr(),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Postal Code').tr(),
                    Text(
                      '${orderDetail.postalCode ?? "No postal code"}',
                      style: TextStyle(color: cartTextColor),
                    ).tr(),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: context.locale == Locale('en', '')
                  ? Alignment.topLeft
                  : Alignment.topRight,
              child: Text(
                'Payment',
                style: TextStyle(color: primaryColor),
              ).tr(),
            ),
            Card(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text('Payment method'.tr()),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${orderDetail.paymentMethod ?? "No selected"}',
                    style: TextStyle(color: cartTextColor),
                  ).tr(),
                  Divider(
                    color: Colors.grey,
                  ),
                  PaymentColumn(
                    total: total != null
                        ? total.toString()
                        : orderDetail.total.toString(),
                    flatShippingRate: widget.shipRate ?? "1",
                    subTotal: subTotal != null
                        ? subTotal.toString()
                        : orderDetail.total.toString(),
                  )
                ],
              ),
            )),
            if (orderDetail.cart.length > 0 && orderDetail.status != "returned")
              GestureDetector(
                onTap: () async {
                  print("@BEFORE ${orderDetail.cart[0].total}");
                  await Navigator.push(
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
                  ).tr(),
                ),
              )
          ],
        ),
      );
    }
    return Center(
      child: Text("No shipping & pricing information available").tr(),
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
                    Text('Address').tr(),
                    Text(
                      '${widget.personal.address ?? "No address"}',
                      style: TextStyle(color: cartTextColor),
                    ).tr(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Country').tr(),
                            Text(
                              '${widget.personal.country ?? "No country"}',
                              style: TextStyle(color: cartTextColor),
                            ).tr(),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('City').tr(),
                            Text(
                              '${widget.personal.city ?? "No city"}',
                              style: TextStyle(color: cartTextColor),
                            ).tr(),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Postal Code').tr(),
                    Text(
                      '${widget.personal.postal ?? "No postal code"}',
                      style: TextStyle(color: cartTextColor),
                    ).tr(),
                    Divider(
                      color: Colors.grey,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Payment',
                        style: TextStyle(color: primaryColor),
                      ).tr(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Payment method'.tr()),
                    Text(
                      '${widget.personal.paymentMethod ?? "No selected"}',
                      style: TextStyle(color: cartTextColor),
                    ).tr(),
                    Divider(
                      color: Colors.grey,
                    ),
                    PaymentColumn(
                      total: widget.total.toString(),
                      flatShippingRate: widget.shipRate ?? '1',
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
      child: Text("No shipping & pricing information available").tr(),
    );
  }
}
