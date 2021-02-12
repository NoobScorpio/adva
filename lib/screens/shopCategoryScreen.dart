import 'package:adva/screens/filterScreen.dart';
import 'package:adva/screens/productContainer.dart';
import 'package:adva/screens/productDetailScreen.dart';
import 'package:adva/screens/productViewScreen.dart';
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
  List<String> sortValues = ['Sort by', 'High to Low', 'Low to High'];
  String sortVal = 'Sort by';
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FilterScreen()));
                      },
                      child: Container(
                        width: screenWidth * 0.24,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 0.1, color: Colors.black)),
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
                            Icon(Icons.filter_list_outlined),
                          ],
                        ),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            icon: Icon(
                              Icons.sort,
                              size: 25,
                            ),
                            iconSize: 42,
                            value: sortVal,
                            focusColor: primaryColor,
                            underline: SizedBox(),
                            items: sortValues.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text('$value'),
                              );
                            }).toList(),
                            onChanged: (_) {
                              setState(() {
                                sortVal = _;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.1,
                      height: screenHeight * 0.05,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black)),
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              box = !box;
                            });
                          },
                          child: !box
                              ? Icon(Icons.widgets_outlined)
                              : Icon(Icons.list)),
                    ),
                  ],
                ),
              ),
              //SHOP BY BRAND AND CATEGORY
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: Container(
                  // screenHeight: screenHeight * 0.26,
                  width: screenWidth,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.01, left: screenWidth * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shop by brand',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Container(
                          height: screenHeight * 0.08,
                          width: screenWidth,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ShopSlideContainer(
                                img: 'assets/images/beautybar.png',
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: ShopSlideContainer(
                                  img: 'assets/images/beautybar.png',
                                ),
                              ),
                              ShopSlideContainer(
                                img: 'assets/images/melia.png',
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: ShopSlideContainer(
                                  img: 'assets/images/beautybar.png',
                                ),
                              ),
                              ShopSlideContainer(
                                img: 'assets/images/melia.png',
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
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.5),
                          ),
                        ),
                        CategoriesListView(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.005,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //PRODUCTS
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
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductViewScreen()));
                          },
                          child: ProductContainer(
                            box: true,
                            screenHeight: screenHeight,
                            image: 'assets/images/product1.png',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: ProductContainer(
                          box: true,
                          screenHeight: screenHeight,
                          image: 'assets/images/product2.png',
                        ),
                      ),
                    ],
                  ),
                ),
              if (!box)
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ProductViewScreen()));
                        },
                        child: ProductContainer(
                          box: false,
                          screenHeight: screenHeight,
                          image: 'assets/images/product1.png',
                        ),
                      ),
                    ),
                  ],
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
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
