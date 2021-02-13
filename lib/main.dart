import 'package:adva/bloc/ads_bloc/adsBloc.dart';
import 'package:adva/bloc/category_bloc/categoryBloc.dart';
import 'package:adva/bloc/featured_bloc/featuredBloc.dart';
import 'package:adva/bloc/offer_bloc/offerBloc.dart';
import 'package:adva/bloc/product_bloc/productBloc.dart';
import 'package:adva/bloc/seller_bloc/sellerBloc.dart';
import 'package:adva/data/repository/adsRepo.dart';
import 'package:adva/data/repository/categoryRepo.dart';
import 'package:adva/data/repository/featuredRepo.dart';
import 'package:adva/data/repository/offerRepo.dart';
import 'package:adva/data/repository/productRepo.dart';
import 'package:adva/data/repository/sellerRepo.dart';
import 'package:adva/ui/screens/bottomNavBar.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AdsBloc>(
            create: (context) => AdsBloc(repository: AdsRepositoryImpl())),
        BlocProvider<CategoryBloc>(
            create: (context) =>
                CategoryBloc(repository: CategoryRepositoryImpl())),
        BlocProvider<OfferBloc>(
            create: (context) => OfferBloc(repository: OfferRepositoryImpl())),
        BlocProvider<SellerBloc>(
            create: (context) =>
                SellerBloc(repository: SellerRepositoryImpl())),
        BlocProvider<FeaturedBloc>(
            create: (context) =>
                FeaturedBloc(repository: FeaturedRepositoryImpl())),
        BlocProvider<ProductBloc>(
            create: (context) =>
                ProductBloc(repository: ProductRepositoryImpl())),
      ],
      child: MaterialApp(
        title: 'ADVA',
        theme: ThemeData(
          primaryColor: primaryColor,
          textTheme: GoogleFonts.caudexTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: BottomNavBar(),
        // home: TestScreen(),
      ),
    );
  }
}
