import 'package:adva/bloc/product_bloc/getIDProductCubit.dart';
import 'package:adva/data/model/featured.dart';
import 'package:adva/data/model/product.dart';
import 'file:///C:/Users/CIFER/AndroidStudioProjects/adva/lib/ui/utils/productContainer.dart';
import 'package:adva/ui/screens/productViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget makeProducts(screenHeight, products, box, context) {
  List<Widget> widgets = [];
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
  return box
      ? GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(15),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.60,
          children: widgets,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        )
      : ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: widgets,
        );
}

Widget getProduct({product, context, screenHeight, box}) {
  return GestureDetector(
    onTap: () {
      BlocProvider.of<GetIDProductCubit>(context).getProduct(product.id);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductViewScreen(pid: product.id)));
    },
    child: ProductContainer(
      box: box,
      pid: product.id,
      name: product.productName,
      price: product.price.toString(),
      screenHeight: screenHeight,
      image: product.productimages[0].pictureReference,
    ),
  );
}
