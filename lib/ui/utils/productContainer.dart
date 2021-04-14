import 'dart:convert';

import 'package:adva/bloc/cart_bloc/cartCubit.dart';
import 'package:adva/bloc/wishlist_bloc/wishCubit.dart';
import 'package:adva/data/model/cartItem.dart';
import 'package:adva/data/model/product.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/model/wishlist.dart';
import 'package:adva/data/repository/productRepo.dart';
import 'package:adva/ui/screens/accountsloginScreen.dart';
import 'package:adva/ui/screens/loginScreen.dart';
import 'package:adva/ui/screens/productViewScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:easy_localization/easy_localization.dart';

class ProductContainer extends StatefulWidget {
  ProductContainer({
    this.screenHeight,
    this.image,
    this.box,
    this.product,
    this.name,
    this.description,
    this.price,
    this.pid,
  });

  final double screenHeight;
  final String image;
  final bool box;
  final int pid;
  final String name, description;
  final String price;
  final dynamic product;
  @override
  _ProductContainerState createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  bool wish = false;
  List<WishList> wishes = [];
  bool english;
  Icon wishIcon;
  SharedPreferences sp;

  pressed() async {
    print(widget.pid);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductViewScreen(pid: widget.pid)));
  }

  @override
  void initState() {
    super.initState();
    setWishes();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => setWishes());
    wishIcon = Icon(
      Icons.favorite_border,
      color: primaryColor,
    );
  }

  bool loggedIn = false;
  setWishes() async {
    sp = await SharedPreferences.getInstance();
    english = sp.getBool('english') ?? true;

    loggedIn = sp.getBool('loggedIn');
  }

  bool tagBool = true;
  @override
  Widget build(BuildContext context) {
    String tag = '';
    var pDate = widget.product.createdAt.toString().split('T')[0];
    var pDateSplit = pDate.split('-');
    var today = DateTime.now();
    var date = DateTime(int.parse(pDateSplit[0]), int.parse(pDateSplit[1]),
        int.parse(pDateSplit[2]));
    Duration difference = today.difference(date);
    if (difference.inDays < 31 && widget.product.quantity > 0) {
      tag = 'New'.tr();
      tagBool = true;
    } else if (difference.inDays > 31 && widget.product.quantity > 0) {
      tag = '';
      tagBool = false;
    } else if (widget.product.quantity == 0) {
      tag = 'Out of Stock'.tr();
      tagBool = false;
    }
    double screenHeight = MediaQuery.of(context).size.height;
    return widget.box
        ? AspectRatio(
            aspectRatio: 2 / 3.9,
            child: Container(
              // constraints: BoxConstraints(maxHeight: 300),
              width: 235,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 0.6, color: primaryColor)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 235,
                    width: double.maxFinite,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: pressed,
                          child: CachedNetworkImage(
                            imageUrl: widget.image,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: imageProvider,
                                  )),
                            ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    buildLoading(),
                            errorWidget: (context, url, error) => Center(
                                child: Icon(
                              Icons.error,
                              color: primaryColor,
                            )),
                          ),
                        ),
                        if (tag != '')
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Align(
                              alignment: context.locale == Locale('en', '')
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: Container(
                                  height: 30,
                                  width:
                                      tag == "New" || tag == "جديد" ? 50 : 100,
                                  color: tagBool ? Colors.black : Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        tag,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        // Center(
                        //   child: Icon(Icons.category),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                            alignment: context.locale == Locale('en', '')
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: InkWell(
                              onTap: () async {
                                showToast("Adding product", primaryColor);
                                if (!wish) {
                                  SharedPreferences sp =
                                      await SharedPreferences.getInstance();
                                  sp = await SharedPreferences.getInstance();
                                  if (sp.getBool('loggedIn') == null ||
                                      sp.getBool('loggedIn') == false) {
                                    showToast(
                                        "You are not logged in", primaryColor);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => AccountsLoginScreen(
                                                  product: true,
                                                )));
                                  } else {
                                    int response =
                                        await BlocProvider.of<WishCubit>(
                                                context)
                                            .addWishListItem(
                                                User.fromJson(json.decode(
                                                        sp.getString('user')))
                                                    .id,
                                                widget.pid);
                                    print('WISH ADDED $response');

                                    if (response == 200) {
                                      showToast(
                                          "Added to wish list", primaryColor);
                                      setState(() {
                                        wish = true;
                                        wishIcon = Icon(Icons.favorite_rounded,
                                            color: primaryColor);
                                      });
                                    } else if (response == 400) {
                                      setState(() {
                                        wish = false;
                                        wishIcon = Icon(
                                            Icons.favorite_border_outlined,
                                            color: primaryColor);
                                      });
                                      showToast(
                                          "Added to wish list", primaryColor);
                                    } else if (response == 500) {
                                      showToast("Not added to wish list",
                                          primaryColor);
                                    }
                                  }
                                } else
                                  showToast("Item already added", primaryColor);
                              },
                              child: wishIcon,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: context.locale == Locale('en', '')
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: GestureDetector(
                      onTap: pressed,
                      child: Container(
                        height: 65,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            left: 5,
                            right: 5,
                          ),
                          child: Text(
                            '${context.locale == Locale('en', '') ? widget.product.productName : widget.product.productArabicName}',
                            textScaleFactor: 1,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: context.locale == Locale('en', '')
                                ? TextAlign.left
                                : TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: GestureDetector(
                            onTap: pressed,
                            child: Align(
                              alignment: context.locale == Locale('en', '')
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: widget.product.timer == 0
                                    ? Text(
                                        'SAR'.tr() + ' ${widget.price}',
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Row(
                                        children: [
                                          Text(
                                            'SAR'.tr() + ' ${widget.price}',
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                decorationColor: Colors.red,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'SAR'.tr() +
                                                ' ${double.parse(widget.price) - widget.product.discountedAmount}',
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (widget.product.quantity == 0) {
                            showToast('Out of Stock', primaryColor);
                          } else {
                            // showToast('Adding Item to Cart', primaryColor);

                            if (loggedIn == null || loggedIn == false) {
                              showToast('Not Logged In', primaryColor);
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AccountsLoginScreen(
                                            product: true,
                                          )));
                              loggedIn = sp.getBool('loggedIn');
                            } else {
                              String userString = sp.getString('user');

                              var user = User.fromJson(json.decode(userString));
                              print("@USER ${user.name}");
                              // Product product = await ProductRepositoryImpl()
                              //     .getProductByID(widget.pid);
                              if (user != null && user.id != null) {
                                if (widget.product != null &&
                                    widget.product.id != null) {
                                  print("@PRODUCT ${widget.product.id}");
                                  print(
                                      "@PRODUCT ${widget.product.productName}");
                                  print(
                                      "@PRODUCT ${widget.product.productimages}");
                                  print("@PRODUCT VAT ${widget.product.vat}");
                                  // print("@PRODUCT ${product.category}");

                                  CartItem cartItem = CartItem();
                                  cartItem.pName = widget.product.productName;
                                  cartItem.arabicName =
                                      widget.product.productArabicName;
                                  cartItem.price = widget.product.timer == 1
                                      ? widget.product.price -
                                          widget.product.discountedAmount
                                      : widget.product.price;
                                  cartItem.image =
                                      widget.product.productimages == null
                                          ? null
                                          : widget.product.productimages[0]
                                              .pictureReference;
                                  cartItem.desc =
                                      widget.product.productDescription;
                                  cartItem.arabicDesc =
                                      widget.product.productArabicDescription;
                                  cartItem.pid = widget.product.id;
                                  cartItem.discount =
                                      widget.product.discountedAmount;
                                  cartItem.oldPrice = widget.product.price;
                                  cartItem.vat = widget.product.vat;
                                  cartItem.categoryID =
                                      widget.product.categoryId;
                                  cartItem.category = widget.product.category ==
                                          null
                                      ? null
                                      : widget.product.category.categoryName;
                                  cartItem.qty = 1;

                                  bool added =
                                      await BlocProvider.of<CartCubit>(context)
                                          .addItem(cartItem);
                                  if (added) {
                                    {
                                      showToast("Added to cart", primaryColor);
                                      // Get the position of the current widget when clicked, and pass in overlayEntry

                                    }
                                  } else
                                    showToast(
                                        'Could not add to cart', primaryColor);
                                } else
                                  showToast(
                                      "Product not available", primaryColor);
                              } else {
                                showToast(
                                    "You are not logged in", primaryColor);
                              }
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: primaryColor.withOpacity(0.5),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 0.6, color: primaryColor)),
                child: Row(
                  children: [
                    //IMAGE
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                          height: 150,
                          width: screenHeight * 0.22,
                          child: Stack(
                            children: [
                              Container(
                                constraints: BoxConstraints.expand(),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                        image: NetworkImage(widget.image),
                                        fit: BoxFit.cover)),
                              ),
                              if (tag != '')
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                      height: 30,
                                      width: tag == "New" || tag == "جديد"
                                          ? 50
                                          : 100,
                                      color:
                                          tagBool ? Colors.black : Colors.red,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Center(
                                          child: Text(
                                            tag,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )),
                                ),
                            ],
                          )),
                    ),
                    //COL
                    Expanded(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () async {
                                    showToast("Adding product", primaryColor);
                                    if (!wish) {
                                      // setState(() {});
                                      sp =
                                          await SharedPreferences.getInstance();
                                      if (sp.getBool('loggedIn') == null ||
                                          sp.getBool('loggedIn') == false) {
                                        showToast("You are not logged in",
                                            primaryColor);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    AccountsLoginScreen(
                                                      product: true,
                                                    )));
                                      } else {
                                        int response = await BlocProvider.of<
                                                WishCubit>(context)
                                            .addWishListItem(
                                                User.fromJson(json.decode(
                                                        sp.getString('user')))
                                                    .id,
                                                widget.pid);
                                        print('WISH ADDED $response');
                                        setState(() {
                                          if (response == 200) {
                                            showToast("Added to wish list",
                                                primaryColor);
                                          } else if (response == 400) {
                                            showToast("Added to wish list",
                                                primaryColor);
                                          } else if (response == 500) {
                                            showToast("Not added to wish list",
                                                primaryColor);
                                          }
                                        });
                                      }
                                    } else
                                      showToast(
                                          "Item already added", primaryColor);
                                  },
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: primaryColor,
                                          size: 20,
                                        ),
                                      ),
                                      Text(
                                        'Add to Wishlist',
                                        style: TextStyle(color: primaryColor),
                                      ).tr(),
                                    ],
                                  ),
                                )),
                          ),
                          GestureDetector(
                            onTap: pressed,
                            child: Container(
                              // width: double.maxFinite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //NAME
                                  Text(
                                    '${context.locale == Locale('en', '') ? widget.product.productName : widget.product.productArabicName}',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  //DESC
                                  Container(
                                    // height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      '${context.locale == Locale('en', '') ? widget.product.productDescription : widget.product.productArabicDescription}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  //PRICE
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: GestureDetector(
                                          onTap: pressed,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: widget.product.timer == 0
                                                ? Text(
                                                    'SAR'.tr() +
                                                        ' ${widget.price}',
                                                    textScaleFactor: 1,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : Row(
                                                    children: [
                                                      Text(
                                                        'SAR'.tr() +
                                                            ' ${widget.price}',
                                                        textScaleFactor: 1,
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            decorationColor:
                                                                Colors.red,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'SAR'.tr() +
                                                            ' ${double.parse(widget.price) - widget.product.discountedAmount}',
                                                        textScaleFactor: 1,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if (widget.product.quantity == 0) {
                                            showToast(
                                                'Out of Stock', primaryColor);
                                          } else {
                                            // showToast('Adding Item to Cart', primaryColor);

                                            if (loggedIn == null ||
                                                loggedIn == false) {
                                              showToast('Not Logged In',
                                                  primaryColor);
                                              await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          AccountsLoginScreen(
                                                            product: true,
                                                          )));
                                              loggedIn = sp.getBool('loggedIn');
                                            } else {
                                              String userString =
                                                  sp.getString('user');

                                              var user = User.fromJson(
                                                  json.decode(userString));
                                              print("@USER ${user.name}");
                                              // Product product = await ProductRepositoryImpl()
                                              //     .getProductByID(widget.pid);
                                              if (user != null &&
                                                  user.id != null) {
                                                if (widget.product != null &&
                                                    widget.product.id != null) {
                                                  print(
                                                      "@PRODUCT ${widget.product.id}");
                                                  print(
                                                      "@PRODUCT ${widget.product.productName}");
                                                  print(
                                                      "@PRODUCT ${widget.product.productimages}");
                                                  print(
                                                      "@PRODUCT VAT ${widget.product.vat}");
                                                  // print("@PRODUCT ${product.category}");

                                                  CartItem cartItem =
                                                      CartItem();
                                                  cartItem.pName = widget
                                                      .product.productName;
                                                  cartItem.arabicName = widget
                                                      .product
                                                      .productArabicName;
                                                  cartItem.price = widget
                                                              .product.timer ==
                                                          1
                                                      ? widget.product.price -
                                                          widget.product
                                                              .discountedAmount
                                                      : widget.product.price;
                                                  cartItem.image = widget
                                                              .product
                                                              .productimages ==
                                                          null
                                                      ? null
                                                      : widget
                                                          .product
                                                          .productimages[0]
                                                          .pictureReference;
                                                  cartItem.desc = widget.product
                                                      .productDescription;
                                                  cartItem.arabicDesc = widget
                                                      .product
                                                      .productArabicDescription;
                                                  cartItem.pid =
                                                      widget.product.id;
                                                  cartItem.discount = widget
                                                      .product.discountedAmount;
                                                  cartItem.oldPrice =
                                                      widget.product.price;
                                                  cartItem.vat =
                                                      widget.product.vat;
                                                  cartItem.categoryID =
                                                      widget.product.categoryId;
                                                  cartItem.category =
                                                      widget.product.category ==
                                                              null
                                                          ? null
                                                          : widget
                                                              .product
                                                              .category
                                                              .categoryName;
                                                  cartItem.qty = 1;

                                                  bool added =
                                                      await BlocProvider.of<
                                                                  CartCubit>(
                                                              context)
                                                          .addItem(cartItem);
                                                  if (added) {
                                                    {
                                                      showToast("Added to cart",
                                                          primaryColor);
                                                      // Get the position of the current widget when clicked, and pass in overlayEntry

                                                    }
                                                  } else
                                                    showToast(
                                                        'Could not add to cart',
                                                        primaryColor);
                                                } else
                                                  showToast(
                                                      "Product not available",
                                                      primaryColor);
                                              } else {
                                                showToast(
                                                    "You are not logged in",
                                                    primaryColor);
                                              }
                                            }
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                primaryColor.withOpacity(0.5),
                                            child: Icon(
                                              Icons.shopping_cart_outlined,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    )
                  ],
                )),
          );
  }
}
