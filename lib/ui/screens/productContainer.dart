import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductContainer extends StatelessWidget {
  ProductContainer({this.screenHeight, this.image, this.box});

  final double screenHeight;
  final String image;
  final bool box;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return box
        ? Container(
            width: screenHeight * 0.216,
            decoration: BoxDecoration(
                border: Border.all(width: 0.6, color: primaryColor)),
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
                      padding:
                          const EdgeInsets.only(top: 10, left: 12, right: 12),
                      child: Text(
                        'Product Name',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 12, right: 12),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur sadipiscing elit,',
                        // max
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
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
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                          child: Icon(
                            Icons.favorite_border,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                  height: 100,
                                  width: screenHeight * 0.22,
                                  child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.asset(image))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Product Name',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '75.00',
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
                                  Column(
                                    children: [
                                      Container(
                                        width: screenHeight * 0.25,
                                        // color: Colors.blue,
                                        // width: double.maxFinite,
                                        child: Text(
                                          'Lorem ipsum dol Lorem ipsum dol '
                                          'Lorem ipsum dol Lorem ipsum dol ',
                                          // max
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
