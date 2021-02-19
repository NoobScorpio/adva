import 'dart:convert';

import 'package:adva/bloc/ads_bloc/adsState.dart';
import 'package:adva/bloc/ads_bloc/getAdsCubit.dart';
import 'package:adva/bloc/brand_bloc/getBrandsCubit.dart';
import 'package:adva/bloc/category_bloc/categoryState.dart';
import 'package:adva/bloc/category_bloc/getCategoryCubit.dart';
import 'package:adva/bloc/category_bloc/getCategoryProductsCubit.dart';
import 'package:adva/bloc/featured_bloc/featuredState.dart';
import 'package:adva/bloc/featured_bloc/getFeaturedCubit.dart';
import 'package:adva/bloc/offer_bloc/getOffersCubit.dart';
import 'package:adva/bloc/offer_bloc/offerState.dart';
import 'package:adva/bloc/product_bloc/getIDProductCubit.dart';
import 'package:adva/bloc/product_bloc/postQuestionCubit.dart';
import 'package:adva/bloc/seller_bloc/getSellerCubit.dart';
import 'package:adva/bloc/seller_bloc/sellerState.dart';
import 'package:adva/data/model/ads.dart';
import 'package:adva/data/model/category.dart';
import 'package:adva/data/model/featured.dart';
import 'package:adva/data/model/offer.dart';
import 'package:adva/data/model/seller.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/repository/productRepo.dart';
import 'file:///C:/Users/CIFER/AndroidStudioProjects/adva/lib/ui/utils/productContainer.dart';
import 'package:adva/ui/screens/productViewScreen.dart';
import 'package:adva/ui/screens/categoryScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/makeProducts.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            //ADS
            Container(
              width: screenWidth,
              child: Stack(
                children: [
                  SizedBox(
                    height: screenHeight * 0.365,
                    width: screenWidth,
                    child: BlocBuilder<GetAdsCubit, AdsState>(
                      builder: (context, state) {
                        if (state is AdsInitialState) {
                          return buildLoading();
                        } else if (state is AdsLoadingState) {
                          return buildLoading();
                        } else if (state is AdsLoadedState) {
                          if (state.ads == null) {
                            return Center(
                                child: CircularProgressIndicator(
                              backgroundColor: primaryColor,
                            ));
                          } else {
                            var ads = state.ads;
                            List<Widget> images = [];
                            for (Ads ad in ads) {
                              images.add(Container(
                                  width: double.maxFinite,
                                  height: screenHeight * 0.365,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Image.network(
                                      ad.media,
                                      fit: BoxFit.cover,
                                    ),
                                  )));
                            }

                            return Carousel(
                              autoplayDuration: Duration(seconds: 10),
                              boxFit: BoxFit.contain,
                              dotBgColor: Colors.transparent,
                              overlayShadowColors: Color(0xFF00000029),
                              images: images,
                            );
                          }
                        } else if (state is AdsErrorState) {
                          return buildErrorUi(state.message);
                        } else {
                          return buildErrorUi('LAST ELSE');
                        }
                      },
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
            //CATEGORIES
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                height: 45,
                child: BlocBuilder<GetCategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryInitialState) {
                      return buildLoading();
                    } else if (state is CategoryLoadingState) {
                      return buildLoading();
                    } else if (state is CategoryLoadedState) {
                      if (state.category == null) {
                        return Center(
                            child: CircularProgressIndicator(
                          backgroundColor: primaryColor,
                        ));
                      } else {
                        var cats = state.category;
                        List<Widget> widgets = [];
                        for (Category cat in cats) {
                          widgets.add(Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: MyButton(
                              height: 40,
                              width: 150,
                              innerColor: Colors.white,
                              borderColor: Colors.grey[300],
                              onPressed: () {
                                BlocProvider.of<GetCategoryProductsCubit>(
                                        context)
                                    .getCategoryProducts(cat.id.toString());
                                BlocProvider.of<GetBrandsCubit>(context)
                                    .getBrands();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ShopCategoryScreen(
                                              cid: cat.id.toString(),
                                              brand: false,
                                            )));
                              },
                              child: Text(
                                '${cat.categoryName}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ));
                        }

                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: widgets,
                        );
                      }
                    } else if (state is CategoryErrorState) {
                      return buildErrorUi(state.message);
                    } else {
                      return buildErrorUi('Could not load data.');
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            Center(
              child: Text(
                'Offers',
                style: TextStyle(fontSize: 21),
              ),
            ),
            //OFFERS
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                height: 150,
                child: BlocBuilder<GetOfferCubit, OfferState>(
                  builder: (context, state) {
                    if (state is OfferInitialState) {
                      return buildLoading();
                    } else if (state is OfferLoadingState) {
                      return buildLoading();
                    } else if (state is OfferLoadedState) {
                      if (state.offer == null) {
                        return Center(
                            child: CircularProgressIndicator(
                          backgroundColor: primaryColor,
                        ));
                      } else {
                        List<Offer> offers = state.offer;
                        List<Widget> widgets = [
                          SizedBox(
                            width: 10,
                          )
                        ];
                        for (Offer offer in offers) {
                          widgets.add(Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      Colors.grey[300], // red as border color
                                ),
                              ),
                              height: 150,
                              width: 150,
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(
                                  offer.image,
                                ),
                              ),
                            ),
                          ));
                        }

                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: widgets,
                        );
                      }
                    } else if (state is OfferErrorState) {
                      return buildErrorUi(state.message);
                    } else {
                      return buildErrorUi('Could not load data.');
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.028,
            ),
            //TOP SELLERS
            Container(
              height: 170,
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
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Container(
                      height: 100,
                      child: BlocBuilder<GetSellerCubit, SellerState>(
                        builder: (context, state) {
                          if (state is SellerInitialState) {
                            return buildLoading();
                          } else if (state is SellerLoadingState) {
                            return buildLoading();
                          } else if (state is SellerLoadedState) {
                            if (state.seller == null) {
                              return Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: primaryColor,
                              ));
                            } else {
                              List<Seller> selling = state.seller;
                              List<Widget> widgets = [
                                SizedBox(
                                  width: 10,
                                )
                              ];
                              // print(sellings.length);
                              for (Seller selling in selling) {
                                // print(
                                //     selling.productimages[0].pictureReference);

                                widgets.add(GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<GetIDProductCubit>(context)
                                        .getProduct(selling.id);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductViewScreen(
                                                    pid: selling.id)));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors
                                              .grey[300], // red as border color
                                        ),
                                      ),
                                      height: 100,
                                      width: 100,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Image.network(
                                          selling.productimages[0]
                                              .pictureReference,
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                              }

                              return ListView(
                                scrollDirection: Axis.horizontal,
                                children: widgets,
                              );
                            }
                          } else if (state is SellerErrorState) {
                            return buildErrorUi(state.message);
                          } else {
                            return buildErrorUi('Could not load data.');
                          }
                        },
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
            // Featured products
            Container(
              width: double.maxFinite,
              // height: 400,
              child: BlocConsumer<GetFeaturedCubit, FeaturedState>(
                listener: (context, state) {
                  if (!(state is FeaturedLoadedState)) {
                    BlocProvider.of<GetFeaturedCubit>(context).getSellers();
                  }
                },
                builder: (context, state) {
                  print('INSIDE BRAND');
                  if (state is FeaturedInitialState) {
                    return buildLoading();
                  } else if (state is FeaturedLoadingState) {
                    return buildLoading();
                  } else if (state is FeaturedLoadedState) {
                    if (state.featured == null) {
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: primaryColor,
                      ));
                    } else
                      return makeProducts(
                          screenHeight, state.featured, true, context);
                  } else if (state is FeaturedErrorState) {
                    return buildErrorUi(state.message);
                  } else {
                    return buildErrorUi('Could not load data.');
                  }
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     SharedPreferences sp = await SharedPreferences.getInstance();
      //     User u = User.fromJson(json.decode(sp.getString('user')));
      //     print(u.id);
      //   },
      // ),
    );
  }
}
