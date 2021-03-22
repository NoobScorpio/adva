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
import 'package:adva/bloc/seller_bloc/getSellerCubit.dart';
import 'package:adva/bloc/seller_bloc/sellerState.dart';
import 'package:adva/data/model/ads.dart';
import 'package:adva/data/model/bundle.dart';
import 'package:adva/data/model/category.dart';
import 'package:adva/data/model/offer.dart';
import 'package:adva/data/model/seller.dart';
import 'package:adva/data/repository/miscRepo.dart';
import 'package:adva/ui/screens/productViewScreen.dart';
import 'package:adva/ui/screens/categoryScreen.dart';
import 'package:adva/ui/screens/productsScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/makeProducts.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final search;

  const HomeScreen({Key key, this.search}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var suggestionTFC = TextEditingController();
  var value;
  dynamic shipRate = 0.0;
  List suggestionList;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  @override
  void initState() {
    super.initState();
    suggestionList = widget.search;
    getShipRate();
  }

  getShipRate() async {
    // SharedPreferences sp = await SharedPreferences.getInstance();
    dynamic rate = await MiscRepositoryImpl().getFreeShipRate();
    if (rate != null)
      setState(() {
        shipRate = rate;
      });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    // WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: screenWidth,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            height: 130,
                            child: AutoCompleteTextField(
                              key: key,
                              controller: suggestionTFC,
                              suggestions: suggestionList,
                              clearOnSubmit: true,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 0.1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  hintText: 'Search'.tr(),
                                  contentPadding: EdgeInsets.only(
                                      top: screenHeight * 0.01,
                                      left: screenWidth * 0.03),
                                  suffixIcon: GestureDetector(
                                      onTap: () async {
                                        // List<SearchProduct> prods =
                                        //     await ProductRepositoryImpl()
                                        //         .getAllProducts(
                                        //             search:
                                        //                 suggestionTFC.text);
                                        // if (prods != null) {
                                        //   setState(() {
                                        //     suggestionList = prods;
                                        //   });
                                        // }
                                      },
                                      child: Icon(Icons.search,
                                          color: Colors.black))),
                              itemFilter: (item, query) {
                                return item.productName
                                    .toLowerCase()
                                    .startsWith(query.toLowerCase());
                              },
                              itemSorter: (a, b) {
                                return a.productName.compareTo(b.productName);
                              },
                              itemSubmitted: (item) {
                                suggestionTFC.text = item.productName;
                              },
                              itemBuilder: (context, item) {
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    ProductViewScreen(
                                                      pid: item.id,
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            item.productName,
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //ADS
            Container(
              width: screenWidth,
              child: Stack(
                children: [
                  SizedBox(
                    height: screenHeight * 0.30,
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
                                height: screenHeight * 0.30,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(ad.media),
                                  ),
                                ),
                              ));
                            }

                            return Carousel(
                              autoplayDuration: Duration(seconds: 25),
                              boxFit: BoxFit.fill,
                              dotColor: Colors.white.withOpacity(0.25),
                              dotBgColor: Colors.transparent,
                              dotIncreasedColor: Colors.white,
                              dotIncreaseSize: 1.2,
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
                  if (context.locale == Locale('en', ''))
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: 60,
                        width: screenWidth * 0.68,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(80),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Free Shipping".tr() +
                                    " " +
                                    "above".tr() +
                                    " $shipRate",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2.0),
                              ).tr(),
                              // Text(
                              //   "above".tr() + " $shipRate",
                              //   style: TextStyle(
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.w500,
                              //       letterSpacing: 2.0),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (!(context.locale == Locale('en', '')))
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        width: screenWidth * 0.65,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(80),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "شحن مجاني للطلبات الاكثر",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2.0),
                              ).tr(),
                              Text(
                                " من $shipRate ريال ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //CATEGORIES
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
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
                            child: GestureDetector(
                              onTap: () {
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
                              child: Container(
                                constraints: BoxConstraints(minWidth: 50),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),

                                // height: 40,

                                // width: 150,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${context.locale == Locale('en', '') ? cat.categoryName : cat.categoryArabicName}',
                                      style: TextStyle(color: Colors.black),
                                    ),
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
              ).tr(),
            ),
            //OFFERS
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                // height: 150,
                child: BlocBuilder<GetOfferCubit, OfferState>(
                  builder: (context, state) {
                    if (state is OfferInitialState) {
                      return buildLoading();
                    } else if (state is OfferLoadingState) {
                      return buildLoading();
                    } else if (state is OfferLoadedState) {
                      if (state.offer == null && state.bundle == null) {
                        return buildErrorUi("No offers Available");
                      }
                      if (state.offer == null || state.offer.length == 0) {
                        return buildErrorUi("No offers Available");
                      } else {
                        List<Offer> offers = state.offer;
                        List<Bundle> bundles = state.bundle;
                        List<Widget> widgets = [];
                        for (Offer offer in offers) {
                          widgets.add(GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductsScreen(oid: offer.id)));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(offer.image),
                                    ),
                                    border: Border.all(
                                      color: Colors
                                          .grey[300], // red as border color
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                width: screenWidth * 0.25,
                                height: 120,
                              ),
                            ),
                          ));
                        }
                        if (bundles != null)
                          for (Bundle bundle in bundles) {
                            widgets.add(GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductViewScreen(
                                              pid: bundle.id,
                                            )));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(bundle.productimages
                                            .first.pictureReference),
                                      ),
                                      border: Border.all(
                                        color: Colors
                                            .grey[300], // red as border color
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  width: screenWidth * 0.25,
                                  height: 120,
                                ),
                              ),
                            ));
                          }
                        return GridView.count(
                          crossAxisCount: 3,
                          padding: const EdgeInsets.all(10),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          // childAspectRatio: 0.5,
                          children: widgets,
                          shrinkWrap: true,

                          physics: NeverScrollableScrollPhysics(),
                        );
                        // return ListView(
                        //   scrollDirection: Axis.horizontal,
                        //   children: widgets,
                        // );
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
              height: 300,
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
                    ).tr(),
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Container(
                      height: 200,
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
                              List<Widget> widgets = [];
                              for (Seller selling in selling) {
                                widgets.add(InkWell(
                                  onTap: () async {
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
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(selling
                                                .productimages[0]
                                                .pictureReference),
                                          ),
                                          border: Border.all(
                                            color: Colors.grey[
                                                300], // red as border color
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      width: 100,
                                      height: 150,
                                    ),
                                  ),
                                ));
                              }

                              return Swiper(
                                itemBuilder: (BuildContext context, int index) {
                                  return widgets[index];
                                },
                                itemCount: widgets.length,
                                viewportFraction: 0.45,
                                scale: 0.70,
                              );
                              // ListWheelScrollViewX.useDelegate(
                              //     itemExtent: 180,
                              //     diameterRatio: 2.5,
                              //     scrollDirection: Axis.horizontal,
                              //     childDelegate:
                              //         ListWheelChildLoopingListDelegate(
                              //             children: widgets));
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
                ).tr(),
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
                  // print('INSIDE BRAND');
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
    );
  }
}
