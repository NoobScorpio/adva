import 'package:adva/data/model/featured.dart';
import 'package:adva/data/model/product.dart';
import 'package:adva/ui/utils/productContainer.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Widget makeProducts(screenHeight, screenWidth, products, box, context,
    {message}) {
  print("@ HEIGHT $screenHeight");
  List<Widget> widgets = [];
  if (products.length > 0) {
    if (products[0].runtimeType == Product) {
      for (Product product in products) {
        widgets.add(getProduct(
            product: product,
            context: context,
            screenHeight: screenHeight,
            box: box));
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
          ? (
              // GridView.count(
              //           crossAxisCount: 2,
              //           padding: const EdgeInsets.all(15),
              //           crossAxisSpacing: 10,
              //           mainAxisSpacing: 10,
              //           childAspectRatio: 0.525,
              //           children: widgets,
              //           shrinkWrap: true,
              //           physics: NeverScrollableScrollPhysics(),
              //         ) ??
              GridView.builder(
              itemCount: widgets.length,
              padding: const EdgeInsets.all(15),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: screenWidth < 390
                    ? (screenHeight < 750 ? 2 / 4.8 : 2 / 4.65)
                    : 2 / 3.90,
                // screenHeight < 700
                //     ? 00.4650
                //     : (screenHeight > 700 && screenHeight < 750
                //         ? 0.4650
                //         : (screenHeight > 750 && screenHeight < 800
                //             ? 0.4650
                //             : (screenHeight > 800 && screenHeight < 850
                //                 ? 0.51
                //                 : 0.524))),
              ),
              itemBuilder: (context, index) => widgets[index],
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ))
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widgets.length,
              itemBuilder: (context, index) => widgets[index],
            ))
      : Padding(
          padding: const EdgeInsets.only(top: 150.0),
          child: Center(
            child:
                Text(message == null ? 'No product in this Category' : message)
                    .tr(),
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
