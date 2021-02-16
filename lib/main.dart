import 'dart:convert';

import 'package:adva/bloc/ads_bloc/getAdsCubit.dart';
import 'package:adva/bloc/brand_bloc/getBrandProductCubit.dart';
import 'package:adva/bloc/brand_bloc/getBrandsCubit.dart';
import 'package:adva/bloc/cart_bloc/cartBloc.dart';
import 'package:adva/bloc/category_bloc/getCategoryCubit.dart';
import 'package:adva/bloc/category_bloc/getCategoryProductsCubit.dart';
import 'package:adva/bloc/featured_bloc/getFeaturedCubit.dart';
import 'package:adva/bloc/gallery_bloc/getPostsCubit.dart';
import 'package:adva/bloc/offer_bloc/getOffersCubit.dart';
import 'package:adva/bloc/product_bloc/getFilterProductCubit.dart';
import 'package:adva/bloc/product_bloc/getIDProductCubit.dart';
import 'package:adva/bloc/product_bloc/getSortProductCubit.dart';
import 'package:adva/bloc/product_bloc/postQuestionCubit.dart';
import 'package:adva/bloc/product_bloc/postReviewCubit.dart';
import 'package:adva/bloc/seller_bloc/getSellerCubit.dart';
import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/data/model/cart.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/repository/adsRepo.dart';
import 'package:adva/data/repository/brandRepo.dart';
import 'package:adva/data/repository/cartRepo.dart';
import 'package:adva/data/repository/categoryRepo.dart';
import 'package:adva/data/repository/featuredRepo.dart';
import 'package:adva/data/repository/galleryRepo.dart';
import 'package:adva/data/repository/offerRepo.dart';
import 'package:adva/data/repository/productRepo.dart';
import 'package:adva/data/repository/sellerRepo.dart';
import 'package:adva/data/repository/userRepo.dart';
import 'package:adva/ui/screens/bottomNavBar.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Cart cart = Cart();
  User user;
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }

  getPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    user = User.fromJson(json.decode(sharedPreferences.getString('user')));
  }

  @override
  Widget build(BuildContext context) {
    cart.cartItem = [];

    return MultiBlocProvider(
      providers: [
        BlocProvider<GetAdsCubit>(
            create: (context) =>
                GetAdsCubit(adsRepository: AdsRepositoryImpl())),
        BlocProvider<GetOfferCubit>(
            create: (context) =>
                GetOfferCubit(offerRepository: OfferRepositoryImpl())),
        BlocProvider<GetSellerCubit>(
            create: (context) =>
                GetSellerCubit(sellerRepository: SellerRepositoryImpl())),
        BlocProvider<GetFeaturedCubit>(
            create: (context) =>
                GetFeaturedCubit(featuredRepository: FeaturedRepositoryImpl())),
        BlocProvider<GetIDProductCubit>(
            create: (context) =>
                GetIDProductCubit(productRepository: ProductRepositoryImpl())),
        BlocProvider<CartBloc>(
            create: (context) => CartBloc(repository: CartRepositoryImpl())),
        BlocProvider<GetBrandsCubit>(
            create: (context) =>
                GetBrandsCubit(brandRepository: BrandRepositoryImpl())),
        BlocProvider<GetCategoryCubit>(
            create: (context) =>
                GetCategoryCubit(categoryRepository: CategoryRepositoryImpl())),
        BlocProvider<GetCategoryProductsCubit>(
            create: (context) => GetCategoryProductsCubit(
                categoryRepository: CategoryRepositoryImpl())),
        BlocProvider<PostQuestionCubit>(
            create: (context) =>
                PostQuestionCubit(productRepository: ProductRepositoryImpl())),
        BlocProvider<PostReviewCubit>(
            create: (context) =>
                PostReviewCubit(productRepository: ProductRepositoryImpl())),
        BlocProvider<GetBrandProductsCubit>(
            create: (context) =>
                GetBrandProductsCubit(brandRepository: BrandRepositoryImpl())),
        BlocProvider<GetFilterProductCubit>(
            create: (context) => GetFilterProductCubit(
                productRepository: ProductRepositoryImpl())),
        BlocProvider<GetSortProductCubit>(
            create: (context) => GetSortProductCubit(
                productRepository: ProductRepositoryImpl())),
        BlocProvider<GetPostsCubit>(
            create: (context) =>
                GetPostsCubit(galleryRepository: GalleryRepositoryImpl())),
        BlocProvider<UserLogInCubit>(
            create: (context) => UserLogInCubit(
                initial: user == null ? false : true,
                user: user,
                userRepository: UserRepositoryImpl(sharedPreferences))),
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
