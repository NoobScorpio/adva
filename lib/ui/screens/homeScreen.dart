import 'package:adva/ui/screens/productContainer.dart';
import 'package:adva/ui/screens/productViewScreen.dart';
import 'package:adva/ui/utils/categoriesListView.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              width: screenWidth,
              child: Stack(
                children: [
                  SizedBox(
                    height: screenHeight * 0.365,
                    width: screenWidth,
                    child: Carousel(
                      boxFit: BoxFit.contain,
                      dotBgColor: Colors.transparent,
                      overlayShadowColors: Color(0xFF00000029),
                      images: [
                        Container(
                            width: screenWidth,
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Image.asset(
                                    'assets/images/advabeauty.png'))),
                        Container(
                            width: screenWidth,
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Image.asset(
                                    'assets/images/advabeauty.png'))),
                        Container(
                            width: screenWidth,
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Image.asset(
                                    'assets/images/advabeauty.png'))),
                        Container(
                            width: screenWidth,
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Image.asset(
                                    'assets/images/advabeauty.png'))),
                      ],
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.09,
                    width: screenWidth,
                    color: Colors.white.withOpacity(0.9),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/advalogo.png',
                            scale: 2,
                          ),
                          SizedBox(
                            width: screenWidth * 0.03,
                          ),
                          Expanded(
                            child: Form(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: screenHeight * 0.001,
                                    right: screenWidth * 0.03),
                                child: Container(
                                  height: screenHeight * 0.06,
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.always,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.1,
                                          ),
                                        ),
                                        hintText: 'Search',
                                        contentPadding: EdgeInsets.only(
                                            top: screenHeight * 0.01,
                                            left: screenWidth * 0.03),
                                        suffixIcon: Image.asset(
                                            'assets/images/search.png')),
                                    onSaved: (String value) {},
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CategoriesListView(
                screenWidth: screenWidth, screenHeight: screenHeight),
            SizedBox(height: screenHeight * 0.025),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Offers',
                style: TextStyle(fontSize: 21),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.076, top: screenHeight * 0.006),
              child: Row(
                children: [
                  Image.asset('assets/images/foundation.png'),
                  SizedBox(
                    width: screenWidth * 0.03,
                  ),
                  Image.asset('assets/images/foundation.png'),
                  SizedBox(
                    width: screenWidth * 0.03,
                  ),
                  Image.asset('assets/images/foundation.png'),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.028,
            ),
            Container(
              height: screenHeight * 0.19,
              color: Color(0xFFF6EDE8),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.012,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Top Sellers',
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.001),
                    child: Container(
                      height: screenHeight * 0.13,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Image.asset('assets/images/kit.png'),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Image.asset('assets/images/lipstick.png'),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Image.asset('assets/images/brush.png'),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Image.asset('assets/images/kit.png'),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Image.asset('assets/images/brush.png'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Featured products',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
