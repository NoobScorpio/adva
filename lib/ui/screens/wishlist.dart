import 'dart:convert';

import 'package:adva/bloc/wishlist_bloc/wishCubit.dart';
import 'package:adva/bloc/wishlist_bloc/wishState.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/model/wishlist.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Wish list',
          style: TextStyle(color: Colors.black),
        ),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<WishCubit, WishListState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is WishListLoadingState)
                return buildLoading();
              else if (state is WishListInitialState)
                return buildLoading();
              else if (state is WishListLoadedState) {
                if (state.wishLists != null && state.wishLists.length != 0) {
                  List<Widget> widgets = [];
                  widgets.add(SizedBox(
                    height: 15,
                  ));
                  for (WishList wish in state.wishLists) {
                    widgets.add(
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    child: wish.product == null
                                        ? Icon(
                                            Icons.image,
                                            color: Colors.grey,
                                          )
                                        : FittedBox(
                                            fit: BoxFit.cover,
                                            child: Image.network(wish
                                                .product
                                                .productimages[0]
                                                .pictureReference),
                                          ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${wish.product == null ? "Name" : wish.product.productName}',
                                          style: boldTextStyle,
                                        ),
                                        Text(
                                            'Price: SAR. ${wish.product == null ? "??" : wish.product.price}'),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(wish.product == null
                                        ? "Stock"
                                        : wish.product.quantity > 0
                                            ? 'In Stock'
                                            : "Out of stock")
                                  ],
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                showToast('Removing', primaryColor);
                                var sp = await SharedPreferences.getInstance();
                                var id = User.fromJson(
                                        json.decode(sp.getString('user')))
                                    .id;
                                BlocProvider.of<WishCubit>(context)
                                    .removeWishListItem(id, wish.id);
                              },
                              child: Icon(
                                Icons.cancel,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  widgets.add(SizedBox(
                    height: 30,
                  ));
                  return ListView(
                    children: widgets,
                  );
                } else {
                  return buildErrorUi("No item in wish list");
                }
              } else {
                return buildErrorUi("No item in wish list");
              }
            }),
      ),
    );
  }
}
