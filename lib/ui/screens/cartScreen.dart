import 'package:adva/bloc/cart_bloc/cartCubit.dart';
import 'package:adva/bloc/cart_bloc/cartState.dart';
import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/data/model/cartItem.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/screens/checkoutScreen.dart';
import 'package:adva/ui/utils/cartWidgets.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    // TODO: implement initState
    super.initState();
    cartItems = widget.cartItems;

    getItems();
  }

  getItems() async {
    cartItems = [];
    cartItems = await BlocProvider.of<CartCubit>(context).getItems();
  }

  int subTotal = 0;
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
        ),
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
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.03, top: screenHeight * 0.017),
                      child: Text('Items ${state.cartItems.length}'),
                    )));
                for (CartItem cartItem in state.cartItems) {
                  print(cartItem.price);

                  widgets.add(ProductCartContainer(
                      cartItem: cartItem,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth));
                }
                widgets.add(Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: Container(
                    // height: screenHeight * 0.33,
                    decoration: BoxDecoration(color: cartContainerColor),
                    child: Column(
                      children: [
                        CartRow(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            txt: Text('Sub - Total',
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                            txt1: Text('SAR. $subTotal',
                                style: TextStyle(
                                  fontSize: 18,
                                ))),
                        CartRow(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            txt: Text('Total (Inc VAT)',
                                style: TextStyle(
                                    fontSize: 18, color: cartTextColor)),
                            txt1: Text('SAR. ${subTotal + vat}',
                                style: TextStyle(
                                    fontSize: 18, color: cartTextColor))),
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
            BlocConsumer<CartCubit, CartState>(listener: (context, state) {
              if (state is CartItemAddedState) {
                if (state.added != null && state.added.length != 0) {
                  int sub = 0;
                  double v = 0.0;
                  for (var item in state.added) {
                    sub += item.price * item.qty;
                    v += item.price * item.qty * 0.1;
                  }
                  setState(() {
                    subTotal = sub;
                    vat = v;
                  });
                }
              }
              if (state is CartItemRemoveState) {
                if (state.removed != null && state.removed.length != 0) {
                  int sub = 0;
                  double v = 0.0;
                  for (var item in state.removed) {
                    sub += item.price * item.qty;
                    v += item.price * item.qty * 0.1;
                  }
                  setState(() {
                    subTotal = sub;
                    vat = v;
                  });
                }
              }
            }, builder: (context, state) {
              if (state is CartLoadedState) {
                if (state.cartItems != null && state.cartItems.length != 0) {
                  // for (var item in state.cartItems) {
                  //   subTotal += item.price * item.qty;
                  //   vat += item.price * item.qty * 0.1;
                  // }
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
                    child: MyButton(
                      height: screenHeight * 0.08,
                      width: screenWidth,
                      borderColor: Colors.transparent,
                      innerColor: primaryColor,
                      child: Center(
                        child: Text('Buy item(s) for SAR ${subTotal + vat}',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                      onPressed: () async {
                        User user =
                            await BlocProvider.of<UserCubit>(context).getUser();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CheckoutScreen(user: user)));
                      },
                    ),
                  );
                } else {
                  return Column(
                    children: [Text('You may also like.')],
                  );
                }
              } else {
                return Column(
                  children: [Text('You may also like.')],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
