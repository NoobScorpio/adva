import 'package:adva/bloc/product_bloc/getIDProductCubit.dart';
import 'package:adva/data/model/featured.dart';
import 'package:adva/data/model/product.dart';
import 'package:adva/data/model/products.dart';
import 'package:adva/ui/screens/productViewScreen.dart';
import 'package:adva/ui/utils/productContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

Widget makeProducts(screenHeight, products, box, context, {message}) {
  List<Widget> widgets = [];
  if (products.length > 0) {
    if (products[0].runtimeType == Product) {
      for (Product product in products) {
        widgets.add(getProduct(
          product: product,
          context: context,
          screenHeight: screenHeight,
          box: box,
        ));
      }
    } else {
      for (Featured product in products) {
        widgets.add(getProduct(
            product: product,
            context: context,
            screenHeight: screenHeight,
            box: box));
      }
    }
  }
  return widgets.length > 0
      ? (box
          ? GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(15),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: screenHeight * 0.00075,
              children: widgets,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            )
          : ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: widgets,
            ))
      : Padding(
          padding: const EdgeInsets.only(top: 150.0),
          child: Center(
            child:
                Text(message == null ? 'No product in this Category' : message).tr(),
          ),
        );
}

Widget getProduct({product, context, screenHeight, box, sharedPreferences}) {
  return ProductContainer(
    description: product.productDescription,
    product: product,
    box: box,
    pid: product.id,
    name: product.productName,
    price: product.price.toString(),
    screenHeight: screenHeight,
    image: product.productimages[0].pictureReference,
  );
}
