import 'package:adva/screens/QuestionsScreen.dart';
import 'package:adva/screens/productImageViewScreen.dart';
import 'package:adva/screens/reviewScreen.dart';
import 'package:adva/utils/constants.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductViewScreen extends StatefulWidget {
  @override
  _ProductViewScreenState createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  double _rating = 3.5;
  List<String> qtyValue = ["QTY 1", "QTY 2", "QTY 3", "QTY 4", "QTY 5"];

  int colorValue = 0;
  String qtySelected = "QTY 1";
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 450,
                          width: double.maxFinite,
                          child: Carousel(
                            boxFit: BoxFit.contain,
                            dotBgColor: Colors.transparent,
                            overlayShadowColors: Color(0xFF00000029),
                            images: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductImageViewScreen()));
                                },
                                child: Container(
                                    width: screenWidth,
                                    child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Image.asset(
                                            'assets/images/eye.png'))),
                              ),
                              Container(
                                  width: screenWidth,
                                  child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.asset(
                                          'assets/images/eye.png'))),
                              Container(
                                  width: screenWidth,
                                  child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.asset(
                                          'assets/images/eye.png'))),
                              Container(
                                  width: screenWidth,
                                  child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.asset(
                                          'assets/images/eye.png'))),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              height: screenHeight * 0.09,
                              width: screenWidth,
                              color: Colors.white.withOpacity(0.9),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.03),
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
                                              autovalidateMode:
                                                  AutovalidateMode.always,
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 0.1,
                                                    ),
                                                  ),
                                                  hintText: 'Search',
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: screenHeight *
                                                              0.01,
                                                          left: screenWidth *
                                                              0.03),
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
                        Positioned(
                            top: screenHeight * 0.10,
                            right: 15,
                            child: Column(
                              children: [
                                CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.black,
                                    )),
                              ],
                            )),
                      ],
                    ),
                    //TITLE
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Adria Lenses',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Product',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          Text(
                            'SAR. 900',
                            style: TextStyle(
                                decorationColor: Colors.red,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                          Text(
                            '-15%',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                          Text(
                            'SAR. 999',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          Text(
                            '(Ex Tax: SAR. 15)',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ID-12323',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          SizedBox(width: 30),
                          Padding(
                            padding: EdgeInsets.only(right: screenWidth / 2.7),
                            child: Text(
                              'PTS: 245',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: [
                          RatingBarIndicator(
                            rating: _rating,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            itemCount: 5,
                            itemSize: 30.0,
                            unratedColor: Colors.amber.withAlpha(50),
                            direction: Axis.horizontal,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              '(5)',
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                          'sed diam nonumy eirmod tempor invidunt ut labore et dolore magna '
                          'aliquyam erat, sed diam voluptua. At vero eos et accusam et justo '
                          'duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata '
                          'sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, '
                          'consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et'),
                    ),
                    // AVAILABILITY:REMAINING
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('Availability:'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'In Stock',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text('Items Remaining:'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '21',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    // MODEL:COLOR
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('Model:'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'ADRIA',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text('Colors:'),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 40,
                                width: 118,
                                color: primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                    color: Colors.white,
                                    width: double.maxFinite,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: DropdownButton(
                                          value: colorValue,
                                          items: [
                                            DropdownMenuItem(
                                              child: Container(
                                                height: 20,
                                                width: 80,
                                                color: primaryColor,
                                              ),
                                              value: 0,
                                            ),
                                            DropdownMenuItem(
                                              child: Container(
                                                height: 20,
                                                width: 80,
                                                color: secondaryColor,
                                              ),
                                              value: 1,
                                            ),
                                            DropdownMenuItem(
                                                child: Container(
                                                  height: 20,
                                                  width: 80,
                                                  color: Colors.blue,
                                                ),
                                                value: 2),
                                            DropdownMenuItem(
                                                child: Container(
                                                  height: 20,
                                                  width: 80,
                                                  color: Colors.red,
                                                ),
                                                value: 3)
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              colorValue = value;
                                            });
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //  REVIEWS:QUESTIONS
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: DefaultTabController(
                        // The number of tabs / content sections to display.
                        length: 2,

                        child: Container(
                          width: double.maxFinite,
                          height: 850,
                          child: Scaffold(
                            appBar: PreferredSize(
                              preferredSize: Size.fromHeight(50),
                              child: AppBar(
                                backgroundColor: Colors.white,
                                bottom: TabBar(
                                  indicatorColor: primaryColor,
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        'Reviews',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'Questions&Answers',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            body: TabBarView(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.maxFinite,
                                        // height: 150,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                    ),
                                                    radius: 15,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 8.0),
                                                    child: Text('Demo User'),
                                                  ),
                                                  RatingBarIndicator(
                                                    rating: _rating,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                    ),
                                                    itemCount: 5,
                                                    itemSize: 20.0,
                                                    unratedColor: Colors.amber
                                                        .withAlpha(50),
                                                    direction: Axis.horizontal,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                                                  'sed diam nonumy eirmod tempor invidunt ut labore et dolore'
                                                  ' magna aliquyam erat, sed diam voluptua. At vero eos et '
                                                  'accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, '
                                                  'no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum '
                                                  'dolor sit amet, consetetur sadipscing elitr, sed diam nonumy'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.maxFinite,
                                        // height: 150,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                    ),
                                                    radius: 15,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 8.0),
                                                    child: Text('Demo User'),
                                                  ),
                                                  RatingBarIndicator(
                                                    rating: _rating,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                    ),
                                                    itemCount: 5,
                                                    itemSize: 20.0,
                                                    unratedColor: Colors.amber
                                                        .withAlpha(50),
                                                    direction: Axis.horizontal,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                                                  'sed diam nonumy eirmod tempor invidunt ut labore et dolore'
                                                  ' magna aliquyam erat, sed diam voluptua. At vero eos et '
                                                  'accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, '
                                                  'no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum '
                                                  'dolor sit amet, consetetur sadipscing elitr, sed diam nonumy'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReviewScreen(
                                                        appBar: true,
                                                      )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Center(
                                            child: Text(
                                              'ViewAll',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 210,
                                        width: double.maxFinite,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 60,
                                                width: double.maxFinite,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    hintText: 'Type here',
                                                    suffix: IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.send,
                                                        color: primaryColor,
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                  ),
                                                  // autofillHints: ['Type your comment here'],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    RatingBarIndicator(
                                                      rating: _rating,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 30.0,
                                                      unratedColor: Colors.amber
                                                          .withAlpha(50),
                                                      direction:
                                                          Axis.horizontal,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Add Image',
                                                          style: TextStyle(
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Icon(
                                                            Icons
                                                                .photo_outlined,
                                                            color: primaryColor,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.photo_outlined,
                                                          color: Colors.grey,
                                                          size: 35,
                                                        ),
                                                        Icon(
                                                          Icons.photo_outlined,
                                                          color: Colors.grey,
                                                          size: 35,
                                                        ),
                                                        Icon(
                                                          Icons.photo_outlined,
                                                          color: Colors.grey,
                                                          size: 35,
                                                        ),
                                                        Icon(
                                                          Icons.photo_outlined,
                                                          color: Colors.grey,
                                                          size: 35,
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 55,
                                                      width: screenWidth / 2.5,
                                                      child: RaisedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, true);
                                                        },
                                                        color: primaryColor,
                                                        child: Text(
                                                          'Submit Review',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.maxFinite,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              width: double.maxFinite,
                                              // height: 150,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 35,
                                                      height: 35,
                                                      color: primaryColor,
                                                      child: Center(
                                                        child: Text(
                                                          'Q',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 22),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      // height: 150,
                                                      child: Text(
                                                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                                                          'sed diam nonumy eirmod tempor invidunt ut labore et dolore'
                                                          ' magna aliquyam erat, sed diam voluptua. At vero eos et '),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.maxFinite,
                                              // height: 150,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 35,
                                                      height: 35,
                                                      color: Colors.black,
                                                      child: Center(
                                                        child: Text(
                                                          'A',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 22),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      // height: 150,
                                                      child: Text(
                                                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                                                          'sed diam nonumy eirmod tempor invidunt ut labore et dolore'
                                                          ' magna aliquyam erat, sed diam voluptua. At vero eos et '),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              width: double.maxFinite,
                                              // height: 150,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 35,
                                                      height: 35,
                                                      color: primaryColor,
                                                      child: Center(
                                                        child: Text(
                                                          'Q',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 22),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      // height: 150,
                                                      child: Text(
                                                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                                                          'sed diam nonumy eirmod tempor invidunt ut labore et dolore'
                                                          ' magna aliquyam erat, sed diam voluptua. At vero eos et '),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.maxFinite,
                                              // height: 150,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 35,
                                                      height: 35,
                                                      color: Colors.black,
                                                      child: Center(
                                                        child: Text(
                                                          'A',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 22),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      // height: 150,
                                                      child: Text(
                                                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                                                          'sed diam nonumy eirmod tempor invidunt ut labore et dolore'
                                                          ' magna aliquyam erat, sed diam voluptua. At vero eos et '
                                                          'accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, '
                                                          'no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum '
                                                          'dolor sit amet, consetetur sadipscing elitr, sed diam nonumy'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 160,
                                        width: double.maxFinite,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 60,
                                                width: double.maxFinite,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Type your question(s) here',
                                                    suffix: IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.send,
                                                        color: primaryColor,
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                  ),
                                                  // autofillHints: ['Type your comment here'],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Center(
                                                  child: Container(
                                                    height: 50,
                                                    width: screenWidth / 2.5,
                                                    child: RaisedButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, true);
                                                      },
                                                      color: primaryColor,
                                                      child: Text(
                                                        'Ask a Question',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      QuestionsScreen(
                                                        appBar: true,
                                                      )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Center(
                                            child: Text(
                                              'ViewAll',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //YOU MAY ALSO LIKE
                    Container(
                        width: double.maxFinite,
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'You may also like',
                                  style: boldTextStyle,
                                ),
                              ),
                              Container(
                                  height: 220,
                                  width: double.maxFinite,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            width: 200,
                                            height: 200,
                                            child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: Image.asset(
                                                    'assets/images/foundation.png'))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            width: 200,
                                            height: 200,
                                            child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: Image.asset(
                                                    'assets/images/kit.png'))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            width: 200,
                                            height: 200,
                                            child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: Image.asset(
                                                    'assets/images/foundation.png'))),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 55,
                      width: screenWidth / 3,
                      color: primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          color: Colors.white,
                          width: double.maxFinite,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: primaryColor,
                              ),
                              iconSize: 42,
                              value: qtySelected,
                              focusColor: primaryColor,
                              underline: SizedBox(),
                              items: qtyValue.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text('$value'),
                                );
                              }).toList(),
                              onChanged: (_) {
                                setState(() {
                                  qtySelected = _;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      width: screenWidth / 1.8,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        color: primaryColor,
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
