import 'package:adva/bloc/brand_bloc/brandState.dart';
import 'package:adva/bloc/brand_bloc/getBrandsCubit.dart';
import 'package:adva/bloc/category_bloc/categoryState.dart';
import 'package:adva/bloc/category_bloc/getCategoryCubit.dart';
import 'package:adva/bloc/product_bloc/getFilterProductCubit.dart';
import 'package:adva/data/model/brand.dart';
import 'package:adva/data/model/category.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int categoryGroup;
  int brandGroup;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.08,
                width: screenWidth,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.12, color: Colors.black),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                      ).tr(),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                          child: Icon(Icons.clear))
                    ],
                  ),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.07,
                                top: screenHeight * 0.02),
                            child: Text(
                              'Categories',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ).tr(),
                          ),
                          BlocBuilder<GetCategoryCubit, CategoryState>(
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
                                // categoryGroup = state.category[0].id;
                                return makeRadios(values: state.category);
                              }
                            } else if (state is CategoryErrorState) {
                              return buildErrorUi(state.message);
                            } else {
                              return buildErrorUi('Could not load data.');
                            }
                          })
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.07,
                                top: screenHeight * 0.02),
                            child: Text(
                              'Brands',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ).tr(),
                          ),
                          BlocBuilder<GetBrandsCubit, BrandState>(
                              builder: (context, state) {
                            print('INSIDE BRAND');
                            if (state is BrandInitialState) {
                              return buildLoading();
                            } else if (state is BrandLoadingState) {
                              return buildLoading();
                            } else if (state is BrandLoadedState) {
                              if (state.brands == null) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  backgroundColor: primaryColor,
                                ));
                              } else {
                                // brandGroup = state.brands[0].id;
                                return makeRadios(values: state.brands);
                              }
                            } else if (state is BrandErrorState) {
                              return buildErrorUi(state.message);
                            } else {
                              return buildErrorUi('Could not load data.');
                            }
                          }),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: MyButton(
                                innerColor: Colors.white,
                                borderColor: primaryColor,
                                height: 52,
                                // width: double.maxFinite,
                                child: Text('Clear').tr(),
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: MyButton(
                                innerColor: primaryColor,
                                borderColor: Colors.transparent,
                                height: 55,
                                // width: double.maxFinite,
                                child: Text('Apply').tr(),
                                onPressed: () {
                                  BlocProvider.of<GetFilterProductCubit>(
                                          context)
                                      .getFilterProduct(
                                          brandGroup, categoryGroup);
                                  Navigator.pop(context, true);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeRadios({values}) {
    List<Widget> widgets = [];
    if (values[0].runtimeType == Category) {
      for (Category cat in values) {
        widgets.add(
          ListTile(
            title: Text(
              '${context.locale == Locale('en', '') ? cat.categoryName : cat.categoryArabicName}',
            ),
            leading: Radio(
              value: cat.id,
              groupValue: categoryGroup,
              activeColor: primaryColor,
              onChanged: (val) {
                setState(() {
                  categoryGroup = val;
                });
              },
            ),
          ),
        );
      }
    } else {
      for (Brand brand in values) {
        widgets.add(
          ListTile(
            title: Text(
              '${context.locale == Locale('en', '') ? brand.brandName : brand.brandArabicName}',
            ),
            leading: Radio(
              value: brand.id,
              groupValue: brandGroup,
              activeColor: primaryColor,
              onChanged: (val) {
                setState(() {
                  brandGroup = val;
                });
              },
            ),
          ),
        );
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
