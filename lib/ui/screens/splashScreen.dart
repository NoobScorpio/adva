import 'dart:async';
import 'package:adva/bloc/ads_bloc/getAdsCubit.dart';
import 'package:adva/bloc/brand_bloc/getBrandsCubit.dart';
import 'package:adva/bloc/category_bloc/getCategoryCubit.dart';
import 'package:adva/bloc/category_bloc/getCategoryProductsCubit.dart';
import 'package:adva/bloc/offer_bloc/getOffersCubit.dart';
import 'package:adva/bloc/seller_bloc/getSellerCubit.dart';
import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/ui/screens/bottomNavBar.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adva/bloc/featured_bloc/getFeaturedCubit.dart';
import 'package:easy_localization/easy_localization.dart';

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
    BlocProvider.of<GetOfferCubit>(context).getOffers();
    BlocProvider.of<GetSellerCubit>(context).getSellers();
    BlocProvider.of<GetFeaturedCubit>(context).getSellers();
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

      BlocProvider.of<UserCubit>(context).setStatus(false);
    } else {
      if (sharedPreferences.getBool('loggedIn')) {
        // await BlocProvider.of<WishCubit>(context).getWishLists(
        //     User.fromJson(json.decode(sharedPreferences.getString('user'))).id);
        sharedPreferences.setBool('loggedIn', true);
        BlocProvider.of<UserCubit>(context).setStatus(true);
      }
    }
  }

  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(context, MaterialPageRoute(builder: (_) {
              // if (sharedPreferences.getBool('loggedIn'))
              //   BlocProvider.of<WishCubit>(context).getWishLists(User.fromJson(
              //           json.decode(sharedPreferences.getString('user')))
              //       .id);
              return BottomNavBar();
            })));

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Image.asset('assets/images/advalogo.png'),
                ),
              ),
              Text('Own your makeup').tr(),
            ],
          ),
          CircularProgressIndicator(
            backgroundColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
