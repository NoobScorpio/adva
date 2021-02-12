import 'package:adva/bloc/ads_bloc/adsBloc.dart';
import 'package:adva/bloc/ads_bloc/adsEvent.dart';
import 'package:adva/bloc/ads_bloc/adsState.dart';
import 'package:adva/bloc/category_bloc/categoryBloc.dart';
import 'package:adva/bloc/category_bloc/categoryEvent.dart';
import 'package:adva/bloc/category_bloc/categoryState.dart';
import 'package:adva/data/model/ads.dart';
import 'package:adva/data/model/category.dart';
import 'package:adva/ui/screens/productContainer.dart';
import 'package:adva/ui/screens/productViewScreen.dart';
import 'package:adva/ui/utils/categoriesListView.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AdsBloc adsBloc;
  CategoryBloc categoryBloc;
  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adsBloc = BlocProvider.of<AdsBloc>(context);
    adsBloc.add(FetchAdsEvent());
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    categoryBloc.add(FetchCategoryEvent());
  }

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
                    child: BlocBuilder<AdsBloc, AdsState>(
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
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Image.network(
                                      ad.media,
                                      fit: BoxFit.cover,
                                    ),
                                  )));
                            }

                            return Carousel(
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                child: BlocBuilder<CategoryBloc, CategoryState>(
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
                        List<Widget> images = [];
                        for (Category cat in cats) {
                          images.add(Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: MyButton(
                              height: 50,
                              width: 100,
                              innerColor: Colors.white,
                              borderColor: Colors.grey,
                              onPressed: () {},
                              child: Text(
                                '${cat.categoryName}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ));
                        }

                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: images,
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
            // Center(
            //   child: IconButton(
            //     icon: Icon(Icons.refresh),
            //     onPressed: () {
            //       adsBloc.add(FetchAdsEvent());
            //     },
            //   ),
            // ),
            // Center(
            //   child: Container(
            //     child:
            //   ),
            // ),
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
