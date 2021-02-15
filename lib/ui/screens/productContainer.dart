import 'package:adva/bloc/product_bloc/productBloc.dart';
import 'package:adva/bloc/product_bloc/productEvent.dart';
import 'package:adva/ui/screens/productViewScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductContainer extends StatefulWidget {
  ProductContainer(
      {this.screenHeight,
      this.image,
      this.box,
      this.name,
      this.description,
      this.price,
      this.pid});

  final double screenHeight;
  final String image;
  final bool box;
  final int pid;
  final String name, description;
  final String price;

  @override
  _ProductContainerState createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  ProductBloc productBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return widget.box
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductViewScreen(pid: widget.pid)));
            },
            child: Container(
              width: screenHeight * 0.216,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.6, color: primaryColor)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            Container(
                              width: screenHeight * 0.25,
                              height: 220,
                              child: FittedBox(
                                child: Image.network(widget.image),
                                fit: BoxFit.cover,
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
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 12, right: 12),
                        child: Text(
                          '${widget.name}',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 12, right: 12),
                        child: Text(
                          '${widget.description}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          // max
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${widget.price}',
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
                                      child: Image.asset(widget.image))),
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
