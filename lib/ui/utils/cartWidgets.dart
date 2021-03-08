import 'dart:convert';

import 'package:adva/bloc/cart_bloc/cartCubit.dart';
import 'package:adva/bloc/wishlist_bloc/wishCubit.dart';
import 'package:adva/data/model/cartItem.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

Widget emptyCart() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 50,
      ),
      Center(child: Image.asset('assets/images/emptycart.png')),
      SizedBox(
        height: 15,
      ),
      Center(
        child: Text(
          'Your cart is empty \nAdd items in cart to display',
          style: TextStyle(fontSize: 21, color: cartTextColor),
          textAlign: TextAlign.center,
        ).tr(),
      ),
    ],
  );
}

class CartRow extends StatelessWidget {
  const CartRow({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.txt,
    @required this.txt1,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final Text txt;
  final Text txt1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.025,
          left: screenWidth * 0.032,
          right: screenWidth * 0.032),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          txt,
          txt1,
        ],
      ),
    );
  }
}

class ProductCartContainer extends StatelessWidget {
  const ProductCartContainer(
      {Key key,
      @required this.screenHeight,
      @required this.screenWidth,
      this.cartItem,
      this.pid})
      : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final CartItem cartItem;
  final int pid;
  @override
  Widget build(BuildContext context) {
    bool wish = false;
    return Container(
      // height: screenHeight * 0.2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 100,
                              width: screenWidth * 0.27,
                              child: cartItem.image == null
                                  ? Icon(
                                      Icons.image,
                                      color: Colors.grey,
                                    )
                                  : Container(
                                      height: 100,
                                      width: screenWidth * 0.27,
                                      constraints: BoxConstraints.expand(),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(cartItem.image),
                                              fit: BoxFit.cover)),
                                    ),
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${cartItem.pName}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Container(
                              width: 130,
                              child: Text(
                                '${cartItem.desc}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                // max
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    //PRICE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SAR'.tr() + '  ',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${cartItem.price}.00',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            showToast("Adding product", primaryColor);
                            if (!wish) {
                              SharedPreferences sp =
                                  await SharedPreferences.getInstance();
                              if (sp.getBool('loggedIn') == null ||
                                  sp.getBool('loggedIn') == false) {
                                showToast(
                                    "You are not logged in", primaryColor);
                              } else {
                                int response =
                                    await BlocProvider.of<WishCubit>(context)
                                        .addWishListItem(
                                            User.fromJson(json.decode(
                                                    sp.getString('user')))
                                                .id,
                                            pid);
                                print('WISH ADDED $response');

                                if (response == 200) {
                                  wish = true;
                                  showToast("Added to wish list", primaryColor);
                                } else if (response == 400) {
                                  wish = true;
                                  showToast("Added to wish list", primaryColor);
                                } else if (response == 500) {
                                  showToast(
                                      "Not added to wish list", primaryColor);
                                }
                              }
                            } else
                              showToast("Item already added", primaryColor);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_outline,
                                color: cartTextColor,
                              ),
                              Text(
                                'Move to wish list',
                                style: TextStyle(color: cartTextColor),
                              ).tr(),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.015),
                                child: SizedBox(
                                  width: 1,
                                  child: Container(
                                    height: 15,
                                    color: cartTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<CartCubit>(context)
                                .removeItem(cartItem, true);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'Remove',
                                style: TextStyle(color: cartTextColor),
                              ).tr(),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<CartCubit>(context)
                                .removeItem(cartItem, false);
                          },
                          child: Container(
                            height: screenHeight * 0.037,
                            width: screenWidth * 0.065,
                            color: primaryColor,
                            child: Icon(Icons.remove, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03),
                          child: Text(
                            '${cartItem.qty}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            cartItem.qty = 1;
                            BlocProvider.of<CartCubit>(context)
                                .addItem(cartItem);
                          },
                          child: Container(
                            height: screenHeight * 0.037,
                            width: screenWidth * 0.065,
                            color: primaryColor,
                            child: Icon(Icons.add, color: Colors.white),
                          ),
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
    );
  }
}

class CartContainer extends StatelessWidget {
  CartContainer({this.screenHeight, this.image});

  final double screenHeight;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: screenHeight * 0.17,
        child: FittedBox(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(image),
        )));
  }
}
