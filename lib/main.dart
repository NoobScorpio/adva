import 'package:adva/bloc/ads_bloc/adsBloc.dart';
import 'package:adva/bloc/category_bloc/categoryBloc.dart';
import 'package:adva/data/repository/adsRepo.dart';
import 'package:adva/data/repository/categoryRepo.dart';
import 'package:adva/res/generatedRoutes.dart';
import 'package:adva/ui/screens/bottomNavBar.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/testScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AdsBloc>(
            create: (context) => AdsBloc(repository: AdsRepositoryImpl())),
        BlocProvider<CategoryBloc>(
            create: (context) =>
                CategoryBloc(repository: CategoryRepositoryImpl())),
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
        onGenerateRoute: _appRouter.onGenerateRoute,
        // home: TestScreen(),
      ),
    );
  }
}
