import 'dart:convert';
import 'package:adva/bloc/cart_bloc/cartCubit.dart';
import 'package:adva/bloc/cart_bloc/cartState.dart';
import 'package:adva/bloc/product_bloc/postQuestionCubit.dart';
import 'package:adva/bloc/wishlist_bloc/wishCubit.dart';
import 'package:adva/data/model/cartItem.dart';
import 'package:adva/data/model/product.dart';
import 'package:adva/data/model/productImage.dart';
import 'package:adva/data/model/qas.dart';
import 'package:adva/data/model/relatedProduct.dart';
import 'package:adva/data/model/review.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/repository/productRepo.dart';
import 'package:adva/ui/screens/accountsloginScreen.dart';
import 'package:adva/ui/screens/productImageViewScreen.dart';
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
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

import 'loginScreen.dart';

class ProductViewScreen extends StatefulWidget {
  final int pid;

  const ProductViewScreen({Key key, this.pid}) : super(key: key);
  @override
  _ProductViewScreenState createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  double _rating = 3.5;
  bool wish = false;
  List<String> qtyValue = [
    "QTY".tr() + " 1",
    "QTY".tr() + " 2",
    "QTY".tr() + " 3",
    "QTY".tr() + " 4",
    "QTY".tr() + " 5"
  ];
  String qtySelected = "QTY".tr() + " 1";
  bool isLoading = true;
  // int colorValue;
  // int sizeValue;
  String pName, arabicName, image, desc, arabicDesc;
  dynamic discount = 0.0;
  dynamic price = 0.0;
  dynamic vat = 0.0;
  TextEditingController quesController;
  // String size = '';
  String category = '';
  int categoryID;
  String message = '';
  List<Widget> reviews = [];
  List<Widget> reviewsNext = [];
  List<Widget> questions = [];
  List<Widget> questionsNext = [];
  // List<int> sizesIntValues = [];
  // List<String> sizesStringValues = [];
  // Map<int, String> sizesMap = {};
  // bool haveColors = false;
  // bool haveSizes = false;
  // List<DropdownMenuItem<int>> colors = [];
  Product product;
  double reviewAvg = 0.0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => settings());
  }

  Widget getCarousel(screenWidth, screenHeight) {
    List<Widget> images = [];
    if (product != null && product.productimages != null) {
      for (Productimages img in product.productimages) {
        images.add(InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        ProductImageViewScreen(images: product.productimages)));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(img.pictureReference),
                  ),
                  border: Border.all(
                    color: Colors.grey[300], // red as border color
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              // width: screenWidth - 50,
              // height: 150,
            ),
          ),
        ));
      }
      print("IMAGES ${product.productimages.length}");
      return Stack(
        children: [
          Container(
              height: 450,
              width: double.maxFinite,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return images[index];
                },
                itemCount: images.length,
                viewportFraction: 0.70,
                scale: 0.65,
              )),
          Positioned(
              top: screenHeight * 0.10,
              right: 15,
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      showToast("Adding product", primaryColor);
                      if (!wish) {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        sp = await SharedPreferences.getInstance();
                        if (sp.getBool('loggedIn') == null ||
                            sp.getBool('loggedIn') == false) {
                          showToast("You are not logged in", primaryColor);
                        } else {
                          int response =
                              await BlocProvider.of<WishCubit>(context)
                                  .addWishListItem(
                                      User.fromJson(
                                              json.decode(sp.getString('user')))
                                          .id,
                                      widget.pid);
                          print('WISH ADDED $response');
                          setState(() {
                            if (response == 200) {
                              showToast("Added to wish list", primaryColor);
                              setState(() {
                                wish = true;
                              });
                            } else if (response == 400) {
                              showToast("Added to wish list", primaryColor);
                            } else if (response == 500) {
                              showToast("Not added to wish list", primaryColor);
                            }
                          });
                        }
                      } else
                        showToast("Item already added", primaryColor);
                    },
                    child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(
                          wish
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      await FlutterShare.share(
                        title: 'ADVA',
                        text:
                            'Do check out this amazing product, visit the link below',
                        linkUrl:
                            'https://www.advabeauty.com/#/products/details/${product.id}',
                      );
                    },
                    child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.share,
                          color: Colors.black,
                        )),
                  ),
                ],
              )),
        ],
      );
    } else
      return Container();
  }

  Widget getDetails(screenWidth, screenHeight) {
    pName = product.productName;
    arabicName = product.productArabicName;
    price = product.price;
    desc = product.productDescription;
    arabicDesc = product.productArabicDescription;
    image = product.productimages == null
        ? ""
        : product.productimages[0].pictureReference;
    discount = product.discountedAmount == null
        ? 0.0
        : product.discountedAmount + 0.0 ?? 0.0;
    vat += product.vat == null ? 0.0 : product.vat + 0.0 ?? 0.0;

    category =
        product.category == null ? "" : product.category.categoryName ?? "";
    categoryID = product.categoryId ?? 1;
    print("@PRODUCTVIEW ${product.discountedAmount}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //TITLE
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            product.productName ?? "",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
        //  PRICE
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ).tr(),
              if (product.discountedAmount != null &&
                  product.discountedAmount != 0 &&
                  product.discountedAmount != '0')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'SAR.'.tr() + ' ${product.price}',
                    style: TextStyle(
                        decorationColor: Colors.red,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ).tr(),
                ),
              if (product.discountedAmount != null &&
                  product.discountedAmount != 0 &&
                  product.discountedAmount != '0')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '-${product.discountedAmount}%',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'SAR.'.tr() +
                      ' ${(product.price ?? 0) - (product.discountedAmount ?? 0)}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
              // Text(
              //   '(Ex Tax: SAR. '.tr() + '${product.tax})',
              //   style: TextStyle(
              //       color: Colors.grey,
              //       fontWeight: FontWeight.w400,
              //       fontSize: 16),
              // ).tr(),
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
                "ID".tr() + ' ${product.id}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              SizedBox(width: 30),
              Padding(
                padding: EdgeInsets.only(right: screenWidth / 2.7),
                child: Text(
                  "PTS".tr() + ' ${product.rewardPoints}',
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
                  '(${product.reviews == null ? 0 : product.reviews.length})',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
        //  DESCRIPTION
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(context.locale == Locale('en', '')
              ? (product.productDescription ?? "")
              : (product.productArabicDescription ?? "")),
        ),
        // AVAILABILITY:REMAINING
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Availability:').tr(),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    (product.quantity ?? 0) > 0 ? 'In Stock' : 'Out of Stock',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ).tr(),
                ],
              ),
              Row(
                children: [
                  Text('Items Remaining:').tr(),
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
      ],
    );
  }

  Widget getReviewsAndQuestions(screenWidth, screenHeight) {
    if (product.reviews != null)
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
      if (product.qas != null) if (product.qas.length > 0) {
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
            child: Text('No Questions available').tr(),
          ));
          questionsNext.add(Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('No Questions available').tr(),
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
                      ).tr(),
                    ),
                    Tab(
                      child: Text(
                        'Questions&Answers',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: primaryColor),
                      ).tr(),
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
                                        addImage: false,
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
                            ).tr(),
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
                                                addImage: false,
                                              )));
                                },
                                child: Container(
                                  height: 60,
                                  width: double.maxFinite,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Type here'.tr(),
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
                                                      addImage: false,
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
                                                      addImage: true,
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'Add Image',
                                            style:
                                                TextStyle(color: primaryColor),
                                          ).tr(),
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
                                                        addImage: false,
                                                      )));
                                        },
                                        color: primaryColor,
                                        child: Text(
                                          'Submit Review',
                                          style: TextStyle(color: Colors.white),
                                        ).tr(),
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
                            ).tr(),
                          ),
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
                                  controller: quesController,
                                  decoration: InputDecoration(
                                    hintText: 'Type your question(s) here'.tr(),
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
                                      ).tr(),
                                    ),
                                  ),
                                ),
                              )
                            ],
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
    // haveSizes = product.sizes == [] ||
    //         product.sizes == null ||
    //         product.sizes.length == 0
    //     ? false
    //     : true;

    // if (haveSizes) {
    //   sizeValue = product.sizes[0].id;
    //   for (var si in product.sizes) {
    //     if (si.size.toString() != ' ') {
    //       sizesIntValues.add(si.id);
    //       sizesStringValues.add(si.size);
    //       sizesMap[si.id] = si.size;
    //       print("IDS : ${si.id}");
    //     }
    //   }
    // }
    // haveColors = product.colors == [] ||
    //         product.colors == null ||
    //         product.colors.length == 0
    //     ? false
    //     : true;

    // if (haveColors) {
    //   colorValue = product.colors[0].id;
    //   for (var clr in product.colors) {
    //     if (clr.color.toString() != ' ') {
    //       print("COLOR: 1${clr.color.toString()}1");
    //       String color = '0xFF' +
    //           clr.color
    //               .toString()
    //               .substring(1, clr.color.toString().length - 1);
    //       print(color);
    //       colors.add(DropdownMenuItem(
    //         child: Text('${clr.color}'),
    //         value: clr.id,
    //       ));
    //     }
    //   }
    // }
    if (product.reviews != null)
      for (Reviews rev in product.reviews) {
        if (!(reviews.length > 0)) {
          reviewAvg += rev.stars.toDouble();
        }
      }
    setState(() {
      if (product == null)
        isLoading = true;
      else
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
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(rp.productimages[0].pictureReference),
                ),
                border: Border.all(
                  color: Colors.grey[300], // red as border color
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            width: 200,
            height: 200,
          ),
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        actions: [
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Image.asset(
                  'assets/images/advalogo.png',
                  scale: 2,
                ),
              ),
            ],
          ))
        ],
      ),
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
                                  ).tr(),
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('$value'),
                                    ),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => AccountsLoginScreen(
                                                product: true,
                                                view: true,
                                              )));
                                } else {
                                  var user = User.fromJson(
                                      json.decode(sp.getString('user')));
                                  if (user != null && user.id != null) {
                                    print(qtySelected.split(' ')[1]);
                                    CartItem cartItem = CartItem();
                                    cartItem.pName = pName;
                                    cartItem.arabicName = arabicName;
                                    cartItem.arabicDesc = arabicDesc;
                                    cartItem.price = price;
                                    cartItem.image = image;
                                    cartItem.desc = desc;
                                    cartItem.pid = product.id;
                                    cartItem.discount = discount;
                                    cartItem.vat = vat;
                                    // cartItem.size = size;
                                    // cartItem.sizeID = sizeValue;
                                    cartItem.categoryID = categoryID;
                                    cartItem.category = category;
                                    cartItem.qty =
                                        int.parse(qtySelected.split(' ')[1]);
                                    // cartItem.color = colorValue;

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
                            ).tr(),
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
                child: buildLoading(),
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
