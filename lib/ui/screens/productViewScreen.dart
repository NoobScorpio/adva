import 'dart:convert';
import 'dart:io';

import 'package:adva/bloc/cart_bloc/cartBloc.dart';
import 'package:adva/bloc/cart_bloc/cartCubit.dart';
import 'package:adva/bloc/cart_bloc/cartEvent.dart';
import 'package:adva/bloc/cart_bloc/cartState.dart';
import 'package:adva/bloc/product_bloc/getIDProductCubit.dart';
import 'package:adva/bloc/product_bloc/postQuestionCubit.dart';
import 'package:adva/bloc/product_bloc/productBloc.dart';
import 'package:adva/bloc/product_bloc/productEvent.dart';
import 'package:adva/bloc/product_bloc/productState.dart';
import 'package:adva/data/model/cartItem.dart';
import 'package:adva/data/model/product.dart';
import 'package:adva/data/model/productImage.dart';
import 'package:adva/data/model/qas.dart';
import 'package:adva/data/model/relatedProduct.dart';
import 'package:adva/data/model/review.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/repository/productRepo.dart';
import 'package:adva/ui/screens/questionsScreen.dart';
import 'package:adva/ui/screens/reviewScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/imagesRow.dart';
import 'package:adva/ui/utils/questionWidget.dart';
import 'package:adva/ui/utils/reviewWidget.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductViewScreen extends StatefulWidget {
  final int pid;

  const ProductViewScreen({Key key, this.pid}) : super(key: key);
  @override
  _ProductViewScreenState createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  double _rating = 3.5;
  List<String> qtyValue = ["QTY 1", "QTY 2", "QTY 3", "QTY 4", "QTY 5"];
  String qtySelected = "QTY 1";
  bool isLoading = true;
  int colorValue;
  int sizeValue;
  String pName, image, desc;
  dynamic discount = 0.0;
  dynamic price = 0.0;
  dynamic vat = 0.0;
  TextEditingController quesController;
  String size = '';
  String category = '';
  int categoryID;
  String message = '';
  List<Widget> reviews = [];
  List<Widget> reviewsNext = [];
  List<Widget> questions = [];
  List<Widget> questionsNext = [];
  List<int> sizesIntValues = [];
  List<String> sizesStringValues = [];
  Map<int, String> sizesMap = {};
  bool haveColors = false;
  bool haveSizes = false;
  List<DropdownMenuItem<int>> colors = [];
  Product product;
  double reviewAvg = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => settings());
  }

  Widget getCarousel(screenWidth, screenHeight) {
    List<Widget> images = [];

    for (Productimages img in product.productimages) {
      images.add(Container(
          width: screenWidth,
          child: FittedBox(
              fit: BoxFit.cover, child: Image.network(img.pictureReference))));
    }
    print("IMAGES ${product.productimages.length}");
    return Stack(
      children: [
        Container(
          height: 450,
          width: double.maxFinite,
          child: Carousel(
            autoplayDuration: Duration(seconds: 10),
            boxFit: BoxFit.contain,
            dotBgColor: Colors.transparent,
            overlayShadowColors: Color(0xFF00000029),
            images: images,
          ),
        ),
        Column(
          children: [
            Container(
              height: screenHeight * 0.09,
              width: screenWidth,
              color: Colors.white.withOpacity(0.9),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
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
                                  suffixIcon:
                                      Image.asset('assets/images/search.png')),
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
    );
  }

  Widget getDetails(screenWidth, screenHeight) {
    pName = product.productName;
    price = product.price;
    desc = product.productDescription;
    image = product.productimages[0].pictureReference;
    discount = product.discountedAmount + 0.0 ?? 0.0;
    vat += product.vat + 0.0 ?? 0.0;

    category = product.category.categoryName ?? "";
    categoryID = product.categoryId ?? 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //TITLE
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            product.productName,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
        //  PRICE
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              Text(
                'SAR. ${product.price}',
                style: TextStyle(
                    decorationColor: Colors.red,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              Text(
                '-${product.discountedAmount}%',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              Text(
                'SAR. ${product.price - product.discountedAmount}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              Text(
                '(Ex Tax: SAR. ${product.tax})',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ],
          ),
        ),
        //  ID
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ID-${product.id}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              SizedBox(width: 30),
              Padding(
                padding: EdgeInsets.only(right: screenWidth / 2.7),
                child: Text(
                  'PTS: ${product.rewardPoints}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        //  STARS
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              RatingBarIndicator(
                rating: reviewAvg,
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
                  '(${product.reviews.length})',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
        //  DESCRIPTION
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(product.productDescription),
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
                    product.quantity > 0 ? 'In Stock' : 'Out of Stock',
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
                    '${product.quantity}',
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
              if (haveColors && colors.length > 0)
                Row(
                  children: [
                    Text(
                      'Colors:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: 118,
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          color: Colors.white,
                          width: double.maxFinite,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: DropdownButton(
                                value: colorValue,
                                items: colors,
                                onChanged: (value) {
                                  setState(() {
                                    colorValue = value;
                                  });
                                }),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              if (haveSizes && sizesStringValues.length > 0)
                Row(
                  children: [
                    Text(
                      'Sizes:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: 130,
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          color: Colors.white,
                          width: double.maxFinite,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child:
                                // DropdownButton<int>(
                                //     value: sizeValue,
                                //     items: sizes,
                                //
                                //     onChanged: (value) {
                                //       setState(() {
                                //         sizeValue = value;
                                //       });
                                //       size = sizesMap[value];
                                //       print("SIZE SELECTED $sizeValue : $size");
                                //     },
                                // ),
                                DropdownButton<int>(
                              isExpanded: true,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: primaryColor,
                              ),
                              iconSize: 42,
                              value: sizeValue,
                              focusColor: primaryColor,
                              items: sizesIntValues.map((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: new Text('${sizesMap[value]}'),
                                );
                              }).toList(),
                              onChanged: (_) {
                                setState(() {
                                  sizeValue = _;
                                  size = sizesMap[_];
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getReviewsAndQuestions(screenWidth, screenHeight) {
    for (Reviews rev in product.reviews) {
      if (!(reviews.length > 0)) {
        reviewAvg += rev.stars.toDouble();
        if (reviews.length < 3) {
          reviews.add(ReviewWidget(
            screenwidth: screenWidth,
            profile:
                rev.customer == null ? null : rev.customer.profileImage ?? '',
            firstName:
                rev.customer == null ? "Anon" : rev.customer.firstName ?? '',
            lastName: rev.customer == null ? "" : rev.customer.lastName ?? '',
            rating: rev.stars ?? 0,
            message: rev.reviewMessage ?? '',
            network: true,
            images: rev.pictures,
          ));
        } else {
          break;
        }
      }
    }

    if (!(questions.length > 0)) {
      if (product.qas.length > 0) {
        for (Qas qas in product.qas) {
          if (questions.length < 3) {
            print("QUESTS LENGTH ${questions.length}");
            questions.add(QuestionWidget(
              screenWidth: screenWidth,
              question: qas.question,
              answer: qas.answer,
              color: primaryColor,
            ));
          }
          questionsNext.add(QuestionWidget(
            screenWidth: screenWidth,
            question: qas.question,
            answer: qas.answer,
            color: primaryColor,
          ));
        }
      } else {
        if (!(questions.length > 0)) {
          questions.add(Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('No Questions available'),
          ));
          questionsNext.add(Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('No Questions available'),
          ));
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.all(15),
      child: DefaultTabController(
        // The number of tabs / content sections to display.
        length: 2,

        child: Container(
          width: double.maxFinite,
          height: product.reviews.length != 0 && product.qas.length != 0
              ? product.reviews.length * 300.toDouble() + 500
              : (product.reviews.length != 0 && product.qas.length == 0
                  ? product.reviews.length * 300.toDouble() + 500
                  : (product.reviews.length == 0 && product.qas.length != 0
                      ? product.qas.length * 300.toDouble() + 500
                      : product.reviews.length == 0 && product.qas.length == 0
                          ? 800
                          : 800)),
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
                            fontWeight: FontWeight.w600, color: primaryColor),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Questions&Answers',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: [
                Container(
                  width: screenWidth,
                  // height: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: reviews,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReviewScreen(
                                        reviews: reviews,
                                        pid: product.id,
                                        appBar: true,
                                        AddImage: false,
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
                                  decoration: TextDecoration.underline),
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReviewScreen(
                                                reviews: reviews,
                                                pid: product.id,
                                                appBar: true,
                                                AddImage: false,
                                              )));
                                },
                                child: Container(
                                  height: 60,
                                  width: double.maxFinite,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Type here',
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                    ),
                                    onChanged: (val) {
                                      if (val.length > message.length) {
                                        message = val;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReviewScreen(
                                                      reviews: reviews,
                                                      pid: product.id,
                                                      appBar: true,
                                                      AddImage: false,
                                                    )));
                                      } else {
                                        message = val;
                                      }
                                    },
                                    // autofillHints: ['Type your comment here'],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReviewScreen(
                                                      reviews: reviews,
                                                      pid: product.id,
                                                      appBar: true,
                                                      AddImage: true,
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'Add Image',
                                            style:
                                                TextStyle(color: primaryColor),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Icon(
                                              Icons.photo_outlined,
                                              color: primaryColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ImagesRow(),
                                    Container(
                                      height: 55,
                                      width: screenWidth / 2.5,
                                      child: RaisedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReviewScreen(
                                                        reviews: reviews,
                                                        pid: product.id,
                                                        appBar: true,
                                                        AddImage: false,
                                                      )));
                                        },
                                        color: primaryColor,
                                        child: Text(
                                          'Submit Review',
                                          style: TextStyle(color: Colors.white),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: questions,
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
                                  controller: quesController,
                                  decoration: InputDecoration(
                                    hintText: 'Type your question(s) here',
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                  onChanged: (val) {
                                    message = val;
                                  },
                                  // autofillHints: ['Type your comment here'],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Center(
                                  child: Container(
                                    height: 50,
                                    width: screenWidth / 2.5,
                                    child: RaisedButton(
                                      onPressed: () async {
                                        if (message.length >= 10) {
                                          bool posted = await BlocProvider.of<
                                                  PostQuestionCubit>(context)
                                              .postQuestion(
                                                  product.id, message, 0);
                                          if (posted) {
                                            setState(() {
                                              questions.add(QuestionWidget(
                                                screenWidth: screenWidth,
                                                question: message,
                                                answer: '',
                                                color: primaryColor,
                                              ));
                                              questionsNext.add(QuestionWidget(
                                                screenWidth: screenWidth,
                                                question: message,
                                                answer: '',
                                                color: primaryColor,
                                              ));
                                            });
                                            quesController.text = '';
                                          } else {
                                            showToast('Question not posted',
                                                primaryColor);
                                          }
                                        } else {
                                          showToast(
                                              'Question should have at least 10 characters',
                                              primaryColor);
                                        }
                                      },
                                      color: primaryColor,
                                      child: Text(
                                        'Ask Question',
                                        style: TextStyle(color: Colors.white),
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
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionsScreen(
                                        pid: product.id,
                                        cid: 0,
                                        questions: questionsNext,
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
                                  decoration: TextDecoration.underline),
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
    );
  }

  settings() async {
    quesController = TextEditingController();
    product = await ProductRepositoryImpl().getProductByID(widget.pid);
    print("PRODUCT ID: ${widget.pid}");
    haveSizes = product.sizes == [] ||
            product.sizes == null ||
            product.sizes.length == 0
        ? false
        : true;

    if (haveSizes) {
      sizeValue = product.sizes[0].id;
      for (var si in product.sizes) {
        if (si.size.toString() != ' ') {
          sizesIntValues.add(si.id);
          sizesStringValues.add(si.size);
          sizesMap[si.id] = si.size;
          print("IDS : ${si.id}");
        }
      }
    }
    haveColors = product.colors == [] ||
            product.colors == null ||
            product.colors.length == 0
        ? false
        : true;

    if (haveColors) {
      colorValue = product.colors[0].id;
      for (var clr in product.colors) {
        if (clr.color.toString() != ' ') {
          print("COLOR: 1${clr.color.toString()}1");
          String color = '0xFF' +
              clr.color
                  .toString()
                  .substring(1, clr.color.toString().length - 1);
          print(color);
          colors.add(DropdownMenuItem(
            child: Text('${clr.color}'),
            value: clr.id,
          ));
        }
      }
    }
    for (Reviews rev in product.reviews) {
      if (!(reviews.length > 0)) {
        reviewAvg += rev.stars.toDouble();
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget getRelatedProducts() {
    List<RelatedProducts> related = product.relatedProducts;
    List<Widget> widgets = [];
    for (RelatedProducts rp in related) {
      widgets.add(GestureDetector(
        onTap: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductViewScreen(pid: rp.id)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: 200,
              height: 200,
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(rp.productimages[0].pictureReference))),
        ),
      ));
    }
    return Container(
        height: 220,
        width: double.maxFinite,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: widgets,
        ));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isLoading)
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //carousel
                      getCarousel(screenWidth, screenHeight),
                      //INFO
                      getDetails(screenWidth, screenHeight),
                      SizedBox(
                        height: 20,
                      ),
                      //  REVIEWS:QUESTIONS
                      getReviewsAndQuestions(screenWidth, screenHeight),
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
                                getRelatedProducts()
                              ],
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          if (!isLoading)
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
                                items: qtyValue.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text('$value'),
                                  );
                                }).toList(),
                                onChanged: (_) {
                                  setState(() {
                                    qtySelected = _;
                                    print(qtySelected);
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      BlocListener<CartCubit, CartState>(
                        listener: (context, state) {},
                        child: Container(
                          height: 55,
                          width: screenWidth / 1.8,
                          child: RaisedButton(
                            onPressed: () async {
                              if (product.quantity == 0) {
                                showToast("Product out of stock", primaryColor);
                              } else {
                                showToast("Adding product", primaryColor);
                                SharedPreferences sp =
                                    await SharedPreferences.getInstance();

                                bool loggedIn = sp.getBool('loggedIn');
                                if (loggedIn == null || loggedIn == false) {
                                  showToast("Not logged in", primaryColor);
                                } else {
                                  var user = User.fromJson(
                                      json.decode(sp.getString('user')));
                                  if (user != null && user.id != null) {
                                    print(qtySelected.split(' ')[1]);
                                    CartItem cartItem = CartItem();
                                    cartItem.pName = pName;
                                    cartItem.price = price;
                                    cartItem.image = image;
                                    cartItem.desc = desc;
                                    cartItem.pid = product.id;
                                    cartItem.discount = discount;
                                    cartItem.vat = vat;
                                    cartItem.size = size;
                                    cartItem.sizeID = sizeValue;
                                    cartItem.categoryID = categoryID;
                                    cartItem.category = category;
                                    cartItem.qty =
                                        int.parse(qtySelected.split(' ')[1]);
                                    cartItem.color = colorValue;
                                    //TODO: CART ITEM ADD
                                    bool added =
                                        await BlocProvider.of<CartCubit>(
                                                context)
                                            .addItem(cartItem);
                                    if (added)
                                      showToast("Product Added to cart",
                                          primaryColor);
                                    else
                                      showToast('Could not add to cart',
                                          primaryColor);
                                  } else {
                                    showToast(
                                        "You are not logged in", primaryColor);
                                  }
                                }
                              }
                            },
                            color: primaryColor,
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (isLoading)
            Padding(
              padding: const EdgeInsets.only(top: 158.0),
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                ),
              ),
            ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      // ),
    );
  }
}
