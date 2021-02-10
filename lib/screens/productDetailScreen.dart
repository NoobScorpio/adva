import 'package:adva/utils/appbarContainer.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppbarContainer(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
            SizedBox(
              height: screenHeight * 0.365,
              width: screenWidth,
              child: Carousel(
                autoplay: false,
                boxFit: BoxFit.contain,
                dotBgColor: Colors.transparent,
                overlayShadowColors: Color(0xFF00000029),
                images: [
                  Container(
                      width: screenWidth,
                      height: screenHeight * 0.5,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.asset('assets/images/eye.png'))),
                  Container(
                      width: screenWidth,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.asset('assets/images/eye.png'))),
                  Container(
                      width: screenWidth,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.asset('assets/images/eye.png'))),
                  Container(
                      width: screenWidth,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.asset('assets/images/eye.png'))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
