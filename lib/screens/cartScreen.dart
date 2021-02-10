import 'package:adva/screens/checkoutScreen.dart';
import 'package:adva/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreeen extends StatefulWidget {
  @override
  _CartScreeenState createState() => _CartScreeenState();
}

class _CartScreeenState extends State<CartScreeen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.12,
        backgroundColor: Colors.white,
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.035),
            child: Text(
              'My Cart',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.03, top: screenHeight * 0.017),
                  child: Text('Items 03'),
                )),

            Column(
              children: [
                ProductCartContainer(
                    screenHeight: screenHeight, screenWidth: screenWidth),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.001),
                  child: ProductCartContainer(
                      screenHeight: screenHeight, screenWidth: screenWidth),
                ),
                ProductCartContainer(
                    screenHeight: screenHeight, screenWidth: screenWidth),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: Container(
                    height: screenHeight * 0.33,
                    decoration: BoxDecoration(color: cartContainerColor),
                    child: Column(
                      children: [
                        CartRow(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          txt: Text('Flat Shipping Rate',
                              style: TextStyle(
                                fontSize: 18,
                              )),
                          txt1: Text('SAR. 999',
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        ),
                        CartRow(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            txt: Text('Sub - Total',
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                            txt1: Text('SAR. 999',
                                style: TextStyle(
                                  fontSize: 18,
                                ))),
                        CartRow(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            txt: Text('Total (Inc VAT)',
                                style: TextStyle(
                                    fontSize: 18, color: cartTextColor)),
                            txt1: Text('SAR. 999',
                                style: TextStyle(
                                    fontSize: 18, color: cartTextColor))),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.2,
                              vertical: screenHeight * 0.018),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/images/mada.png'),
                              Image.asset('assets/images/visa.png'),
                              Image.asset('assets/images/mastercard.png'),
                              Image.asset('assets/images/cashondelivery.png'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //Cart 1st portion

            SizedBox(
              height: screenHeight * 0.19,
            ),
            Center(child: Image.asset('assets/images/emptycart.png')),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Center(
              child: Text(
                '       Your cart is empty \nAdd items in cart to display',
                style: TextStyle(fontSize: 21, color: cartTextColor),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.13,
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.26,
              decoration: BoxDecoration(border: Border.all(width: 0.07)),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.013),
                    child: Text(
                      'You might like',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.19,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CartContainer(
                          screenHeight: screenHeight,
                          image: 'assets/images/kit.png',
                        ),
                        CartContainer(
                          screenHeight: screenHeight,
                          image: 'assets/images/nailpolish.png',
                        ),
                        CartContainer(
                          screenHeight: screenHeight,
                          image: 'assets/images/kit.png',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            CartPaymentButton(
                screenHeight: screenHeight * 0.1, screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }
}

class CartPaymentButton extends StatelessWidget {
  const CartPaymentButton({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
      child: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(border: Border.all(width: 0.07)),
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: MaterialButton(
            color: primaryColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen()));
            },
            child: Text('Buy 3 items for SAR 233.09',
                style: TextStyle(fontSize: 15, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}

class CartRow extends StatelessWidget {
  const CartRow({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.txt,
    @required this.txt1,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final Text txt;
  final Text txt1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.025,
          left: screenWidth * 0.032,
          right: screenWidth * 0.032),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          txt,
          txt1,
        ],
      ),
    );
  }
}

class ProductCartContainer extends StatelessWidget {
  const ProductCartContainer({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Color(0xFFFF4747),
          icon: Icons.delete,
          onTap: () {},
        )
      ],
      child: Container(
        height: screenHeight * 0.2,
        child: Card(
          elevation: 4,
          child: ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.03, top: screenHeight * 0.02),
                        child: Image.asset(
                          'assets/images/product1.png',
                          scale: 3,
                        ),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12, left: 16),
                        child: Text(
                          'Product Name',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 16),
                        child: Text(
                          'Lorem ipsum dolor sit amet,\nconsectetur sadipiscing elit, sed\ndiom neonumy eirmod tempor',
                          // max
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.045, top: screenHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SAR  ',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '75.00',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.027,
                  right: screenWidth * 0.027,
                  top: screenHeight * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_outline,
                          color: cartTextColor,
                        ),
                        Text(
                          'Move to whishlist',
                          style: TextStyle(color: cartTextColor),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.015),
                          child: SizedBox(
                            width: 1,
                            child: Container(
                              height: 15,
                              color: cartTextColor,
                            ),
                          ),
                        ),
                        Image.asset(
                          "assets/images/delete.png",
                          color: cartTextColor,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'Remove',
                          style: TextStyle(color: cartTextColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: screenHeight * 0.037,
                          width: screenWidth * 0.065,
                          color: primaryColor,
                          child: Icon(Icons.remove, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03),
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Container(
                          height: screenHeight * 0.037,
                          width: screenWidth * 0.065,
                          color: primaryColor,
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartContainer extends StatelessWidget {
  CartContainer({this.screenHeight, this.image});

  final double screenHeight;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: screenHeight * 0.17,
        child: FittedBox(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(image),
        )));
  }
}
