import 'package:adva/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductContainer extends StatelessWidget {
  ProductContainer({this.screenHeight, this.image});

  final double screenHeight;
  final String image;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenHeight * 0.216,
      decoration:
          BoxDecoration(border: Border.all(width: 0.6, color: primaryColor)),
      child: Column(
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  width: screenHeight * 0.25,
                  child: FittedBox(
                    child: Image.asset(image),
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.favorite_outline,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
                child: Text(
                  'Product Name',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur sadipiscing elit, sed',
                  // max
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 9, left: 12, right: 19, bottom: 11),
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
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '75.00',
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
        ],
      ),
    );
  }
}
