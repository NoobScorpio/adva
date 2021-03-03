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
import 'package:flutter_svg/flutter_svg.dart';
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

    getPrefs();
  }

  getPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool loggedIn = sharedPreferences.getBool('loggedIn');
    if (loggedIn == null || loggedIn == false) {
      await sharedPreferences.setBool("loggedIn", false);
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
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  bool show = false;
  double height = 500;
  double width = 500;
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).push(PageRouteBuilder(
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
            )));
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
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: Duration(seconds: 2),
                height: height,
                width: width,
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                ),
              ),
            ),
            // if (!show)
            //   Align(
            //       alignment: Alignment.center,
            //       child: Padding(
            //         padding: const EdgeInsets.only(top: 10.0),
            //         child: Text(
            //           'Own your makeup',
            //           style: TextStyle(color: Colors.white),
            //         ).tr(),
            //       )),
            // if (show)
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Own your makeup',
                    style: TextStyle(color: show ? Colors.black : Colors.white),
                  ).tr(),
                )),
            if (!show)
              Center(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 166.0),
                      child: Text(''))),
            if (show)
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                ),
              )),
          ],
        ),
      ),
    );
  }
}
