import 'package:adva/bloc/cart_bloc/cartCubit.dart';
import 'package:adva/data/model/cartItem.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          '       Your cart is empty \nAdd items in cart to display',
          style: TextStyle(fontSize: 21, color: cartTextColor),
        ),
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
      this.cartItem})
      : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final CartItem cartItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: screenHeight * 0.2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
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
                              width: 100,
                              child: cartItem.image == null
                                  ? Icon(
                                      Icons.image,
                                      color: Colors.grey,
                                    )
                                  : Image.network(
                                      cartItem.image,
                                      scale: 3,
                                    ),
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                '${cartItem.pName}',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 16),
                              child: Container(
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
                          'SAR  ',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_outline,
                              color: cartTextColor,
                            ),
                            Text(
                              'Move to whishlist',
                              style: TextStyle(color: cartTextColor),
                            ),
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
                              ),
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
