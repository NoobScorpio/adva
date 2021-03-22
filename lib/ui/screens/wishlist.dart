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
import 'package:easy_localization/easy_localization.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    bool english = context.locale == Locale('en', '');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Wish list',
          style: TextStyle(color: Colors.black),
        ).tr(),
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 6,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(wish
                                                            .product !=
                                                        null
                                                    ? wish
                                                        .product
                                                        .productimages[0]
                                                        .pictureReference
                                                    : "https://i.stack.imgur.com/y9DpT.jpg")),
                                          ),
                                          height: 70,
                                          width: 70,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${wish.product == null ? (english ? "Name" : "") : (english ? wish.product.productName : wish.product.productArabicName)}',
                                              style: boldTextStyle,
                                            ).tr(),
                                            Text('Price'.tr() +
                                                ': ' +
                                                'SAR'.tr() +
                                                '. ${wish.product == null ? "??" : wish.product.price}'),
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
                                            .tr()
                                      ],
                                    )
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    showToast('Removing', primaryColor);
                                    var sp =
                                        await SharedPreferences.getInstance();
                                    var id = User.fromJson(
                                            json.decode(sp.getString('user')))
                                        .id;
                                    BlocProvider.of<WishCubit>(context)
                                        .removeWishListItem(id, wish.id);
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(
                                color: Colors.grey,
                                height: 0.5,
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
