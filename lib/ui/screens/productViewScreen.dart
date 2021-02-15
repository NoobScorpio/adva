import 'package:adva/bloc/cart_bloc/cartBloc.dart';
import 'package:adva/bloc/cart_bloc/cartEvent.dart';
import 'package:adva/bloc/cart_bloc/cartState.dart';
import 'package:adva/bloc/cart_bloc/cartState.dart';
import 'package:adva/bloc/product_bloc/productBloc.dart';
import 'package:adva/bloc/product_bloc/productEvent.dart';
import 'package:adva/bloc/product_bloc/productState.dart';
import 'package:adva/data/model/cart.dart';
import 'package:adva/data/model/cartItem.dart';
import 'package:adva/data/model/colors.dart';
import 'package:adva/data/model/product.dart';
import 'package:adva/data/model/productImage.dart';
import 'package:adva/data/model/qas.dart';
import 'package:adva/data/model/review.dart';
import 'package:adva/ui/screens/QuestionsScreen.dart';
import 'package:adva/ui/screens/productImageViewScreen.dart';
import 'package:adva/ui/screens/reviewScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/questionWidget.dart';
import 'package:adva/ui/utils/reviewWidget.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  ProductBloc productBloc;
  CartBloc cartBloc;
  int colorValue;
  String pName;
  String message;
  List<Widget> reviews = [];
  List<Widget> qases = [];
  Product product;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);
    cartBloc = BlocProvider.of<CartBloc>(context);
    productBloc.add(FetchProductByIDEvent(widget.pid));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cartBloc.close();
    // productBloc.close();
  }

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
                          child: BlocConsumer<ProductBloc, ProductState>(
                            listener: (context, state) {
                              if (state is FetchProductByIDEvent) {
                                if (state is ProductLoadedState) {
                                  if (widget.pid == state.product.id) {
                                    setState(() {
                                      product = state.product;
                                    });
                                  } else {
                                    BlocProvider.of<ProductBloc>(context)
                                        .add(FetchProductByIDEvent(widget.pid));
                                  }
                                }
                              }
                            },
                            builder: (context, state) {
                              if (state is ProductInitialState) {
                                return buildLoading();
                              } else if (state is ProductLoadingState) {
                                return buildLoading();
                              } else if (state is ProductLoadedState) {
                                if (state.product == null ||
                                    state.product.productimages.length < 1) {
                                  return Center(
                                      child: CircularProgressIndicator(
                                    backgroundColor: primaryColor,
                                  ));
                                } else {
                                  if (state is FetchProductByIDEvent) {
                                    product = state.product;
                                    print("PRODUCT");
                                    print(product.id);
                                    List<Widget> images = [];
                                    for (Productimages img
                                        in product.productimages) {
                                      images.add(Container(
                                          width: screenWidth,
                                          child: FittedBox(
                                              fit: BoxFit.cover,
                                              child: Image.network(
                                                  img.pictureReference))));
                                    }

                                    return Carousel(
                                      autoplayDuration: Duration(seconds: 10),
                                      boxFit: BoxFit.contain,
                                      dotBgColor: Colors.transparent,
                                      overlayShadowColors: Color(0xFF00000029),
                                      images: images,
                                    );
                                  } else
                                    return Center(
                                        child: CircularProgressIndicator(
                                      backgroundColor: primaryColor,
                                    ));
                                }
                              } else if (state is ProductErrorState) {
                                return buildErrorUi(state.message);
                              } else {
                                return buildErrorUi('LAST ELSE');
                              }
                            },
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
                    BlocConsumer<ProductBloc, ProductState>(
                      listener: (context, state) {
                        if (state is ProductPostQuestionState) {
                          if (state.posted) {
                            showToast('Question Posted', primaryColor);
                            setState(() {
                              qases.add(QuestionWidget(
                                screenWidth: screenWidth,
                                color: primaryColor,
                                question: message,
                                answer: '',
                              ));
                            });
                          } else
                            showToast('Question not Posted', primaryColor);
                        }
                      },
                      builder: (context, state) {
                        if (state is ProductInitialState) {
                          return buildLoading();
                        } else if (state is ProductLoadingState) {
                          return buildLoading();
                        } else if (state is ProductLoadedState) {
                          if (state.product == null ||
                                  state.product.productimages.length < 1
                              // || state.product.id != widget.pid
                              ) {
                            return Center(
                                child: CircularProgressIndicator(
                              backgroundColor: primaryColor,
                            ));
                          } else {
                            product = state.product;
                            pName = product.productName;
                            double reviewAvg = 0.0;

                            for (Reviews rev in product.reviews) {
                              reviewAvg += rev.stars.toDouble();
                              reviews.add(ReviewWidget(
                                picture: rev.customer.profileImage,
                                firstName: rev.customer.firstName,
                                lastName: rev.customer.lastName,
                                rating: rev.stars,
                                message: rev.reviewMessage,
                              ));
                            }
                            // print("PRODUCT COLORS: " +
                            //     "${product.productColors}");
                            List<DropdownMenuItem<int>> colors = [];
                            colorValue = product.productColors[0].id;
                            for (var clr in product.productColors) {
                              String color = '0xFF' +
                                  clr.color.toString().substring(
                                      1, clr.color.toString().length - 1);
                              print(color);
                              colors.add(DropdownMenuItem(
                                child: Container(
                                  color: Colors.grey[300],
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      height: 20,
                                      width: 80,
                                      color: Color(int.parse(color)),
                                    ),
                                  ),
                                ),
                                value: clr.id,
                              ));
                            }

                            if (product.qas.length > 0) {
                              for (QAS qas in product.qas) {
                                qases.add(QuestionWidget(
                                  screenWidth: screenWidth,
                                  question: qas.question,
                                  answer: qas.answer,
                                  color: primaryColor,
                                ));
                              }
                            } else {
                              qases.add(Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text('No Questions available'),
                              ));
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //TITLE
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    product.productName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                ),
                                //  PRICE
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            decoration:
                                                TextDecoration.lineThrough,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        padding: EdgeInsets.only(
                                            right: screenWidth / 2.7),
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
                                        unratedColor:
                                            Colors.amber.withAlpha(50),
                                        direction: Axis.horizontal,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Availability:'),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            product.quantity > 0
                                                ? 'In Stock'
                                                : 'Out of Stock',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
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
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Model:'),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${product.model}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
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
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Container(
                                                color: Colors.white,
                                                width: double.maxFinite,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
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
                                      height: product.reviews != null
                                          ? product.reviews.length *
                                                  200.toDouble() +
                                              800
                                          : 900.toDouble(),
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
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: primaryColor),
                                                  ),
                                                ),
                                                Tab(
                                                  child: Text(
                                                    'Questions&Answers',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: reviews,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ReviewScreen(
                                                                    reviews:
                                                                        reviews,
                                                                    pid: widget
                                                                        .pid,
                                                                    appBar:
                                                                        true,
                                                                  )));
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Center(
                                                        child: Text(
                                                          'ViewAll',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  primaryColor,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 210,
                                                    width: double.maxFinite,
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            height: 60,
                                                            width: double
                                                                .maxFinite,
                                                            child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'Type here',
                                                                suffix:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {},
                                                                  icon: Icon(
                                                                    Icons.send,
                                                                    color:
                                                                        primaryColor,
                                                                  ),
                                                                ),
                                                                border: OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.black)),
                                                              ),
                                                              // autofillHints: ['Type your comment here'],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                RatingBarIndicator(
                                                                  rating:
                                                                      _rating,
                                                                  itemBuilder:
                                                                      (context,
                                                                              index) =>
                                                                          Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .yellow,
                                                                  ),
                                                                  itemCount: 5,
                                                                  itemSize:
                                                                      30.0,
                                                                  unratedColor: Colors
                                                                      .amber
                                                                      .withAlpha(
                                                                          50),
                                                                  direction: Axis
                                                                      .horizontal,
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
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .photo_outlined,
                                                                        color:
                                                                            primaryColor,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .photo_outlined,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: 35,
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .photo_outlined,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: 35,
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .photo_outlined,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: 35,
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .photo_outlined,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: 35,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  height: 55,
                                                                  width:
                                                                      screenWidth /
                                                                          2.5,
                                                                  child:
                                                                      RaisedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context,
                                                                          true);
                                                                    },
                                                                    color:
                                                                        primaryColor,
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
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: qases,
                                                  ),
                                                  Container(
                                                    height: 160,
                                                    width: double.maxFinite,
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            height: 60,
                                                            width: double
                                                                .maxFinite,
                                                            child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'Type your question(s) here',
                                                                border: OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.black)),
                                                              ),
                                                              onChanged: (val) {
                                                                message = val;
                                                              },
                                                              // autofillHints: ['Type your comment here'],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                            child: Center(
                                                              child: Container(
                                                                height: 50,
                                                                width:
                                                                    screenWidth /
                                                                        2.5,
                                                                child:
                                                                    RaisedButton(
                                                                  onPressed:
                                                                      () {
                                                                    BlocProvider.of<ProductBloc>(
                                                                            context)
                                                                        .add(PostProductQuestionEvent(
                                                                            widget.pid,
                                                                            message,
                                                                            0));
                                                                  },
                                                                  color:
                                                                      primaryColor,
                                                                  child: Text(
                                                                    'Ask Question',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
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
                                                                    pid: widget
                                                                        .pid,
                                                                    cid: 0,
                                                                    questions:
                                                                        qases,
                                                                    appBar:
                                                                        true,
                                                                  )));
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Center(
                                                        child: Text(
                                                          'ViewAll',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  primaryColor,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline),
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
                              ],
                            );
                          }
                        } else if (state is ProductErrorState) {
                          return buildErrorUi(state.message);
                        } else {
                          return buildErrorUi('LAST ELSE');
                        }
                      },
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
                    BlocListener<CartBloc, CartState>(
                      listener: (context, state) {
                        if (state is CartItemAddedState) {
                          if (state.added) {
                            showToast("Added to cart", primaryColor);
                            // Fluttertoast.showToast(
                            //     msg: "Added to cart",
                            //     toastLength: Toast.LENGTH_SHORT,
                            //     gravity: ToastGravity.CENTER,
                            //     timeInSecForIosWeb: 1,
                            //     backgroundColor: primaryColor,
                            //     textColor: Colors.white,
                            //     fontSize: 16.0);
                          } else {
                            showToast('Could not add to cart', primaryColor);
                          }
                        }
                        if (state is GetCartItemState) {
                          print(state.cartItems[0].qty);
                        }
                      },
                      child: Container(
                        height: 55,
                        width: screenWidth / 1.8,
                        child: RaisedButton(
                          onPressed: () {
                            CartItem cartItem = CartItem();
                            cartItem.pName = pName;
                            cartItem.pid = widget.pid;
                            cartItem.qty = int.parse(qtySelected.split(' ')[1]);
                            cartItem.color = colorValue;
                            BlocProvider.of<CartBloc>(context)
                                .add(AddItemCartEvent(cartItem));
                            BlocProvider.of<CartBloc>(context)
                                .add(GetCartItemsEvent());
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
          )
        ],
      ),
    );
  }
}
