import 'package:adva/bloc/address_bloc/addressCubit.dart';
import 'package:adva/bloc/ads_bloc/getAdsCubit.dart';
import 'package:adva/bloc/brand_bloc/getBrandProductCubit.dart';
import 'package:adva/bloc/brand_bloc/getBrandsCubit.dart';
import 'package:adva/bloc/cart_bloc/cartCubit.dart';
import 'package:adva/bloc/category_bloc/getCategoryCubit.dart';
import 'package:adva/bloc/category_bloc/getCategoryProductsCubit.dart';
import 'package:adva/bloc/featured_bloc/getFeaturedCubit.dart';
import 'package:adva/bloc/gallery_bloc/postCubit.dart';
import 'package:adva/bloc/offer_bloc/getOffersCubit.dart';
import 'package:adva/bloc/order_bloc/orderCubit.dart';
import 'package:adva/bloc/points_bloc/pointsCubit.dart';
import 'package:adva/bloc/product_bloc/getFilterProductCubit.dart';
import 'package:adva/bloc/product_bloc/getIDProductCubit.dart';
import 'package:adva/bloc/product_bloc/getSortProductCubit.dart';
import 'package:adva/bloc/product_bloc/postQuestionCubit.dart';
import 'package:adva/bloc/product_bloc/postReviewCubit.dart';
import 'package:adva/bloc/returnCubit.dart';
import 'package:adva/bloc/seller_bloc/getSellerCubit.dart';
import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/bloc/wishlist_bloc/wishCubit.dart';
import 'package:adva/data/model/myCart.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/repository/addressRepo.dart';
import 'package:adva/data/repository/adsRepo.dart';
import 'package:adva/data/repository/brandRepo.dart';
import 'package:adva/data/repository/cartRepo.dart';
import 'package:adva/data/repository/categoryRepo.dart';
import 'package:adva/data/repository/featuredRepo.dart';
import 'package:adva/data/repository/galleryRepo.dart';
import 'package:adva/data/repository/offerRepo.dart';
import 'package:adva/data/repository/orderRepo.dart';
import 'package:adva/data/repository/pointsRepo.dart';
import 'package:adva/data/repository/productRepo.dart';
import 'package:adva/data/repository/sellerRepo.dart';
import 'package:adva/data/repository/userRepo.dart';
import 'package:adva/data/repository/wishRepo.dart';
import 'package:adva/ui/screens/splashScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      child: MyApp(),
      supportedLocales: [const Locale('en', ''), const Locale('ar', 'AE')],
      startLocale: Locale('ar', 'AE'),
      fallbackLocale: Locale('en', ''),
      path: "assets/translations"));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MyCart cart = MyCart();
  User user;
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  getPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool loggedIn = sharedPreferences.getBool('loggedIn');
    if (loggedIn == null) {
      await sharedPreferences.setBool('loggedIn', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    cart.cartItem = [];

    return MultiBlocProvider(
      providers: [
        BlocProvider<GetAdsCubit>(
            create: (context) =>
                GetAdsCubit(adsRepository: AdsRepositoryImpl())),
        BlocProvider<ReturnCubit>(
            create: (context) =>
                ReturnCubit(orderRepository: OrderRepositoryImpl())),
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
        BlocProvider<CartCubit>(
            create: (context) =>
                CartCubit(cartRepository: CartRepositoryImpl())),
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
        BlocProvider<PostsCubit>(
            create: (context) =>
                PostsCubit(galleryRepository: GalleryRepositoryImpl())),
        BlocProvider<UserCubit>(
            create: (context) =>
                UserCubit(userRepository: UserRepositoryImpl())),
        BlocProvider<WishCubit>(
            create: (context) =>
                WishCubit(wishRepository: WishRepositoryImpl())),
        BlocProvider<AddressCubit>(
            create: (context) =>
                AddressCubit(addressRepository: AddressRepositoryImpl())),
        BlocProvider<PointsCubit>(
            create: (context) =>
                PointsCubit(pointsRepository: PointsRepositoryImpl())),
        BlocProvider<OrderCubit>(
            create: (context) =>
                OrderCubit(orderRepository: OrderRepositoryImpl())),
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
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: SplashScreen(),
        // home: TestScreen(),
      ),
    );
  }
}
