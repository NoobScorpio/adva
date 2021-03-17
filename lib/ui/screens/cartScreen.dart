import 'dart:convert';

import 'package:adva/bloc/cart_bloc/cartCubit.dart';
import 'package:adva/bloc/cart_bloc/cartState.dart';
import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/data/model/cartItem.dart';
import 'package:adva/data/model/shipRate.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/screens/checkoutScreen.dart';
import 'package:adva/ui/utils/cartWidgets.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  final cartItems;

  const CartScreen({Key key, this.cartItems}) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems;
  @override
  void initState() {

    super.initState();
    cartItems = widget.cartItems;

    getItems();
  }

  getItems() async {
    cartItems = [];
    cartItems = await BlocProvider.of<CartCubit>(context).getItems();
  }

  double subTotal = 0;
  double vat = 0.0;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'My Cart',
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
        ).tr(),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<CartCubit, CartState>(builder: (context, state) {
              if (state is CartLoadedState) {
                if (state.cartItems == null || state.cartItems.length == 0) {
                  return emptyCart();
                }
                List<Widget> widgets = [];
                widgets.add(Align(
                    alignment: context.locale == Locale('en', '')
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: screenWidth * 0.03,
                          left: screenWidth * 0.03,
                          top: screenHeight * 0.017),
                      child: Text('Items'.tr() + ' ${state.cartItems.length}'),
                    )));
                for (CartItem cartItem in state.cartItems) {
                  print(cartItem.price);

                  widgets.add(ProductCartContainer(
                      pid: cartItem.pid,
                      cartItem: cartItem,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth));
                }
                print("@CART subTotal: ${state.subTotal}");
                dynamic total = state.total, subTotal = state.subTotal;
                widgets.add(Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: Container(
                    // height: screenHeight * 0.33,
                    decoration: BoxDecoration(color: cartContainerColor),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.025,
                              left: screenWidth * 0.032,
                              right: screenWidth * 0.032),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sub - Total',
                                  style: TextStyle(
                                    fontSize: 18,
                                  )).tr(),
                              Row(
                                children: [
                                  Text('SAR'.tr(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      )).tr(),
                                  Text('. $subTotal',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.025,
                              left: screenWidth * 0.032,
                              right: screenWidth * 0.032),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total (Inc VAT)',
                                  style: TextStyle(
                                    fontSize: 18,
                                  )).tr(),
                              Row(
                                children: [
                                  Text('SAR'.tr(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      )).tr(),
                                  Text('. $total',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
                widgets.add(Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/mada.png'),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset('assets/images/visa.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset('assets/images/mCard.png'),
                      ),
                      Image.asset('assets/images/cashondelivery.png'),
                    ],
                  ),
                ));
                return Expanded(
                  child: ListView(
                    children: widgets,
                  ),
                );
              }
              return emptyCart();
            }),
            BlocConsumer<CartCubit, CartState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is CartLoadedState) {
                    if (state.cartItems != null &&
                        state.cartItems.length != 0) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15),
                        child: MyButton(
                          height: screenHeight * 0.08,
                          width: screenWidth,
                          borderColor: Colors.transparent,
                          innerColor: primaryColor,
                          child: Center(
                            child: Text(
                                    'Buy item(s) for SAR '.tr() +
                                        '${state.total}',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white))
                                .tr(),
                          ),
                          onPressed: () async {
                            SharedPreferences sp =
                                await SharedPreferences.getInstance();
                            String rate =  sp.getString('shipRate');
                            ShipRate shipRate =
                                ShipRate.fromJson(json.decode(rate));
                            User user =
                                await BlocProvider.of<UserCubit>(context)
                                    .getUser();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckoutScreen(
                                        user: user,
                                        shipRate: shipRate.shippingRate)));
                          },
                        ),
                      );
                    } else {
                      return Column(
                        children: [Text('')],
                      );
                    }
                  } else {
                    return Column(
                      children: [Text('')],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
