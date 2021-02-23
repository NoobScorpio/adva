import 'dart:async';
import 'dart:convert';

import 'package:adva/bloc/product_bloc/getIDProductCubit.dart';
import 'package:adva/bloc/product_bloc/productBloc.dart';
import 'package:adva/bloc/product_bloc/productEvent.dart';
import 'package:adva/bloc/wishlist_bloc/wishCubit.dart';
import 'package:adva/bloc/wishlist_bloc/wishState.dart';
import 'package:adva/data/model/product.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/model/wishlist.dart';
import 'package:adva/ui/screens/productViewScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductContainer extends StatefulWidget {
  ProductContainer({
    this.screenHeight,
    this.image,
    this.box,
    this.product,
    this.name,
    this.description,
    this.price,
    this.pid,
  });

  final double screenHeight;
  final String image;
  final bool box;
  final int pid;
  final String name, description;
  final String price;
  final dynamic product;
  @override
  _ProductContainerState createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  bool wish = false;
  List<WishList> wishes = [];
  SharedPreferences sp;
  pressed() async {
    Product product = await BlocProvider.of<GetIDProductCubit>(context)
        .getProduct(widget.pid);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductViewScreen(product: product)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setWishes();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => setWishes());
  }

  setWishes() async {
    sp = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    String tag = '';
    var pDate = widget.product.createdAt.toString().split('T')[0];
    var pDateSplit = pDate.split('-');
    var today = DateTime.now();
    var date = DateTime(int.parse(pDateSplit[0]), int.parse(pDateSplit[1]),
        int.parse(pDateSplit[2]));
    Duration difference = today.difference(date);
    if (difference.inDays < 31 && widget.product.quantity > 0) {
      tag = 'New';
    } else if (difference.inDays > 31 && widget.product.quantity > 0) {
      tag = '';
    } else if (widget.product.quantity == 0) {
      tag = 'Out of stock';
    }
    double screenHeight = MediaQuery.of(context).size.height;
    return widget.box
        ? Container(
            width: screenHeight * 0.216,
            decoration: BoxDecoration(
                border: Border.all(width: 0.6, color: primaryColor)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: pressed,
                            child: Container(
                              width: 200,
                              height: 200,
                              child: FittedBox(
                                child: Image.network(widget.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (tag != '')
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                  height: 25,
                                  color:
                                      tag == 'New' ? Colors.black : Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      tag,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: pressed,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 12, right: 12),
                        child: Text(
                          '${widget.name}',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: pressed,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 9, left: 12, right: 15, bottom: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price   ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'SAR  ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${widget.price}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.maxFinite,
              color: primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  width: double.maxFinite,
                  color: Colors.white,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                            padding:
                                const EdgeInsets.only(right: 5.0, top: 5.0),
                            child: GestureDetector(
                              onTap: () async {
                                if (!wish) {
                                  // setState(() {});
                                  sp = await SharedPreferences.getInstance();
                                  if (sp.getBool('loggedIn')) {
                                    int response =
                                        await BlocProvider.of<WishCubit>(
                                                context)
                                            .addWishListItem(
                                                User.fromJson(json.decode(
                                                        sp.getString('user')))
                                                    .id,
                                                widget.pid);
                                    print('WISH ADDED $response');
                                    setState(() {
                                      if (response == 200) {
                                        showToast(
                                            "Added to wish list", primaryColor);
                                      } else if (response == 400) {
                                        showToast(
                                            "Added to wish list", primaryColor);
                                      } else if (response == 500) {
                                        showToast("Not added to wish list",
                                            primaryColor);
                                      }
                                    });
                                  } else
                                    showToast(
                                        "You are not logged in", primaryColor);
                                } else
                                  showToast("Item already added", primaryColor);
                              },
                              child: Text(
                                'Add to Wishlist',
                                style: TextStyle(color: primaryColor),
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: pressed,
                        child: Container(
                          width: double.maxFinite,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                    height: 100,
                                    width: screenHeight * 0.22,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: screenHeight * 0.22,
                                          child: FittedBox(
                                              fit: BoxFit.cover,
                                              child:
                                                  Image.network(widget.image)),
                                        ),
                                        if (tag != '')
                                          Positioned(
                                            top: 8,
                                            left: 8,
                                            child: Container(
                                                height: 25,
                                                color: tag == 'New'
                                                    ? Colors.black
                                                    : Colors.red,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    tag,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )),
                                            // BlocConsumer<WishCubit, WishListState>(
                                            //   listener: (context, state) {
                                            //     if (state is WishListLoadedState) {
                                            //       // Timer(Duration(seconds: 10), () {
                                            //       if (state.wishLists != null &&
                                            //           state.wishLists.length != 0) {
                                            //         // print("WISHLIST LENGTH ${state.wishLists.length}");
                                            //         // for (WishList w in state.wishLists) {
                                            //         //   print("PID: ${widget.pid} ** WPID: ${w.productId}");
                                            //         //   if (w.productId == widget.pid)
                                            //         //     setState(() {
                                            //         //       wish = true;
                                            //         //     });
                                            //         //   break;
                                            //         // }
                                            //       }
                                            //       // });
                                            //     }
                                            //   },
                                            //   builder: (context, state) {
                                            //     return GestureDetector(
                                            //       onTap: () async {
                                            //         if (!wish) {
                                            //           // setState(() {});
                                            //           sp =
                                            //               await SharedPreferences.getInstance();
                                            //           if (sp.getBool('loggedIn')) {
                                            //             setState(() {
                                            //               wish = true;
                                            //             });
                                            //             // if (!wish) {
                                            //             int response = await BlocProvider.of<
                                            //                     WishCubit>(context)
                                            //                 .addWishListItem(
                                            //                     User.fromJson(json.decode(
                                            //                             sp.getString('user')))
                                            //                         .id,
                                            //                     widget.pid);
                                            //             print('WISH ADDED $response');
                                            //             setState(() {
                                            //               if (response == 200) {
                                            //                 setState(() {
                                            //                   wish = true;
                                            //                 });
                                            //                 showToast("Added to wish list",
                                            //                     primaryColor);
                                            //               } else if (response == 400) {
                                            //                 setState(() {
                                            //                   wish = true;
                                            //                 });
                                            //                 showToast("Added to wish list",
                                            //                     primaryColor);
                                            //               } else if (response == 500) {
                                            //                 setState(() {
                                            //                   wish = false;
                                            //                 });
                                            //                 showToast("Not added to wish list",
                                            //                     primaryColor);
                                            //               }
                                            //               // else {
                                            //               //   wish = false;
                                            //               //   showToast("Not added to wish list",
                                            //               //       primaryColor);
                                            //               // }
                                            //             });
                                            //             // }
                                            //             // else {
                                            //             //   bool response =
                                            //             //       await BlocProvider.of<WishCubit>(
                                            //             //               context)
                                            //             //           .removeWishListItem(
                                            //             //               User.fromJson(json.decode(
                                            //             //                       sp.getString('user')))
                                            //             //                   .id,
                                            //             //               widget.pid);
                                            //             //   print('WISH REMOVED $response');
                                            //             //   setState(() {
                                            //             //     if (response)
                                            //             //       wish = false;
                                            //             //     else
                                            //             //       wish = true;
                                            //             //   });
                                            //             // }
                                            //           } else
                                            //             showToast("You are not logged in",
                                            //                 primaryColor);
                                            //         } else
                                            //           showToast(
                                            //               "Item already added", primaryColor);
                                            //       },
                                            //       child: wish
                                            //           ? Icon(
                                            //               Icons.favorite,
                                            //               color: primaryColor,
                                            //               size: 30,
                                            //             )
                                            //           : Icon(
                                            //               Icons.favorite_border,
                                            //               color: primaryColor,
                                            //               size: 30,
                                            //             ),
                                            //     );
                                            //   },
                                            // ),
                                          ),
                                      ],
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 15.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.name}',
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      width: screenHeight * 0.25,
                                      // color: Colors.grey,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Price ',
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'SAR ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '${widget.price}',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
