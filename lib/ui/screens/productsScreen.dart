import 'package:adva/data/model/product.dart';
import 'package:adva/data/model/products.dart';
import 'package:adva/data/repository/offerRepo.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/makeProducts.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  final int oid;

  const ProductsScreen({
    Key key,
    this.oid,
  }) : super(key: key);
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool isLoading = true;
  List<Product> products = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => getProducts());
  }

  getProducts() async {
    products = await OfferRepositoryImpl().getOfferProducts(oid: widget.oid);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Offer Products',
          style: TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: ListView(
        children: [
          if (isLoading)
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                ),
              ),
            ),
          if (!isLoading)
            makeProducts(
                MediaQuery.of(context).size.height, products, true, context,
                message: "No products in this offer"),
        ],
      ),
    );
  }
}
