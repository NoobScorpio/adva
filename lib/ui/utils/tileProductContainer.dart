import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';

class TileProductContainer extends StatefulWidget {
  @override
  _TileProductContainerState createState() => _TileProductContainerState();
}

class _TileProductContainerState extends State<TileProductContainer> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
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
                        fit: BoxFit.contain,
                        child: Image.asset('assets/images/product1.png')),
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
      ),
    );
  }
}
