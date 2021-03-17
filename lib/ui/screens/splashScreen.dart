import 'dart:async';
import 'dart:convert';
import 'package:adva/bloc/ads_bloc/getAdsCubit.dart';
import 'package:adva/bloc/brand_bloc/getBrandsCubit.dart';
import 'package:adva/bloc/category_bloc/getCategoryCubit.dart';
import 'package:adva/bloc/category_bloc/getCategoryProductsCubit.dart';
import 'package:adva/bloc/offer_bloc/getOffersCubit.dart';
import 'package:adva/bloc/seller_bloc/getSellerCubit.dart';
import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/bloc/wishlist_bloc/wishCubit.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/repository/miscRepo.dart';
import 'package:adva/ui/screens/bottomNavBar.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adva/bloc/featured_bloc/getFeaturedCubit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetAdsCubit>(context).getAds();
    BlocProvider.of<GetCategoryCubit>(context).getCategories();
    BlocProvider.of<GetFeaturedCubit>(context).getSellers();
    BlocProvider.of<GetOfferCubit>(context).getOffers();
    BlocProvider.of<GetSellerCubit>(context).getSellers();

    BlocProvider.of<GetBrandsCubit>(context).getBrands();
    BlocProvider.of<GetCategoryProductsCubit>(context)
        .getCategoryProducts("Makeup");
    getPrefs();
  }

  getPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool loggedIn = sharedPreferences.getBool('loggedIn');
    if (loggedIn == null || loggedIn == false) {
      await sharedPreferences.setBool("loggedIn", false);
      await sharedPreferences.setBool("english", true);
      MiscRepositoryImpl misc = MiscRepositoryImpl();
      await misc.getCODRate();
      await misc.getShipRate();
      await misc.getTaxRate();
      BlocProvider.of<UserCubit>(context).setStatus(false);
    } else {
      await BlocProvider.of<WishCubit>(context).getWishLists(
          User.fromJson(json.decode(sharedPreferences.getString('user'))).id);
      await sharedPreferences.setBool('loggedIn', true);
      MiscRepositoryImpl misc = MiscRepositoryImpl();
      await misc.getCODRate();
      await misc.getShipRate();
      await misc.getTaxRate();
      await BlocProvider.of<UserCubit>(context).setStatus(true);
      bool english = sharedPreferences.getBool("english");
      if (english == null || english == true) {
        await sharedPreferences.setBool("english", true);
      } else {
        await sharedPreferences.setBool("english", false);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool show = false;
  double height = 500;
  double width = 500;
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 7),
        () => Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  BottomNavBar(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = Offset(0.0, 1.0);
                var end = Offset.zero;
                var curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
            (route) => false));
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   setState(() {
    //     height = 100;
    //     width = 100;
    //   });
    //   Timer(
    //       Duration(seconds: 3),
    //       () => setState(() {
    //         height = 100;
    //         width = 100;
    //             show = true;
    //           }));
    // });

    // Timer(
    //     Duration(seconds: 3),
    //     () => setState(() {
    //           height = 100;
    //           width = 100;
    //           show = true;
    //         }));
    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: Image.asset(
          'assets/images/intro_black.gif',
          scale: 2,
        ),
      ),
    );
  }
}
