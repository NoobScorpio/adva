import 'package:adva/screens/productContainer.dart';
import 'package:adva/utils/appbarContainer.dart';
import 'package:adva/utils/categoriesListView.dart';
import 'package:adva/utils/constants.dart';
import 'package:adva/utils/generalContainer.dart';
import 'package:flutter/material.dart';

class ShopCategoryScreen extends StatefulWidget {
  @override
  _ShopCategoryScreenState createState() => _ShopCategoryScreenState();
}

class _ShopCategoryScreenState extends State<ShopCategoryScreen> {
  bool box = true;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppbarContainer(
                  screenHeight: screenHeight, screenWidth: screenWidth),
              Padding(
                padding: EdgeInsets.only(
                    right: screenWidth * 0.05, top: screenHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: screenWidth * 0.24,
                      height: screenHeight * 0.05,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black)),
                      child: Row(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.04,
                                  right: screenWidth * 0.02),
                              child: Text(
                                'Filter',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          Image.asset('assets/images/filter.png'),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: Container(
                        width: screenWidth * 0.27,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 0.1, color: Colors.black)),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.04,
                                  right: screenWidth * 0.02),
                              child: Text(
                                'Sort by',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Image.asset('assets/images/sortby.png'),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.1,
                      height: screenHeight * 0.05,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/options.png'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: GeneralContainer(
                  screenHeight: screenHeight * 0.26,
                  screenWidth: screenWidth,
                  column: Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.01, left: screenWidth * 0.03),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shop by brand',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Container(
                              height: screenHeight * 0.07,
                              width: screenWidth,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Row(
                                    children: [
                                      ShopSlideContainer(
                                        img: 'assets/images/beautybar.png',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14),
                                        child: ShopSlideContainer(
                                          img: 'assets/images/melia.png',
                                        ),
                                      ),
                                      ShopSlideContainer(
                                        img: 'assets/images/beautybar.png',
                                      ),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      ShopSlideContainer(
                                        img: 'assets/images/melia.png',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14),
                                        child: ShopSlideContainer(
                                          img: 'assets/images/beautybar.png',
                                        ),
                                      ),
                                      ShopSlideContainer(
                                        img: 'assets/images/melia.png',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14),
                                        child: ShopSlideContainer(
                                          img: 'assets/images/beautybar.png',
                                        ),
                                      ),
                                      ShopSlideContainer(
                                        img: 'assets/images/melia.png',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 0.5,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight * 0.017,
                                  bottom: screenHeight * 0.01),
                              child: Text(
                                'Shop by category',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.5),
                              ),
                            ),
                            CategoriesListView(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              padding:
                                  EdgeInsets.only(left: screenWidth * 0.005),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (box)
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.042,
                      right: screenWidth * 0.042,
                      top: screenHeight * 0.01,
                      bottom: screenHeight * 0.017),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProductContainer(
                        screenHeight: screenHeight,
                        image: 'assets/images/product1.png',
                      ),
                      ProductContainer(
                        screenHeight: screenHeight,
                        image: 'assets/images/product2.png',
                      ),
                    ],
                  ),
                ),
              if (box)
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.042,
                      right: screenWidth * 0.042,
                      top: screenHeight * 0.01,
                      bottom: screenHeight * 0.017),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProductContainer(
                        screenHeight: screenHeight,
                        image: 'assets/images/product1.png',
                      ),
                      ProductContainer(
                        screenHeight: screenHeight,
                        image: 'assets/images/product2.png',
                      ),
                    ],
                  ),
                ),
              if (box)
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.042,
                      right: screenWidth * 0.042,
                      top: screenHeight * 0.01,
                      bottom: screenHeight * 0.017),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProductContainer(
                        screenHeight: screenHeight,
                        image: 'assets/images/product1.png',
                      ),
                      ProductContainer(
                        screenHeight: screenHeight,
                        image: 'assets/images/product2.png',
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

class ShopSlideContainer extends StatelessWidget {
  const ShopSlideContainer({
    Key key,
    this.img,
  }) : super(key: key);

  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.14,
      decoration:
          BoxDecoration(border: Border.all(width: 0.3, color: primaryColor)),
      child: FittedBox(
        child: Image.asset(
          img,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
