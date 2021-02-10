import 'package:adva/utils/white_button.dart';
import 'package:flutter/material.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    Key key,
    @required this.screenWidth,
    @required this.screenHeight,
    this.padding,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding == null
          ? EdgeInsets.only(
              left: screenWidth * 0.05,
              top: screenHeight * 0.001,
              right: screenWidth * 0.05)
          : padding,
      child: Container(
        height: screenHeight * 0.055,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            WhiteButton(
              screenWidth: screenWidth,
              txt: 'Fashion',
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            WhiteButton(
              screenWidth: screenWidth,
              txt: 'Lenses',
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            WhiteButton(
              screenWidth: screenWidth,
              txt: 'Makeup',
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            WhiteButton(
              screenWidth: screenWidth,
              txt: 'Beauty',
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            WhiteButton(
              screenWidth: screenWidth,
              txt: 'Products',
            ),
          ],
        ),
      ),
    );
  }
}
