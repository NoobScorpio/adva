import 'package:adva/bloc/brand_bloc/brandState.dart';
import 'package:adva/bloc/brand_bloc/getBrandProductCubit.dart';
import 'package:adva/bloc/brand_bloc/getBrandsCubit.dart';
import 'package:adva/bloc/category_bloc/categoryState.dart';
import 'package:adva/bloc/category_bloc/getCategoryCubit.dart';
import 'package:adva/bloc/category_bloc/getCategoryProductsCubit.dart';
import 'package:adva/bloc/product_bloc/getFilterProductCubit.dart';
import 'package:adva/bloc/product_bloc/getSortProductCubit.dart';
import 'package:adva/bloc/product_bloc/productState.dart';
import 'package:adva/data/model/brand.dart';
import 'package:adva/data/model/category.dart';
import 'package:adva/ui/screens/filterScreen.dart';
import 'package:adva/ui/utils/appbarContainer.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/makeProducts.dart';
import 'package:adva/ui/utils/notFound.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class ShopCategoryScreen extends StatefulWidget {
  final cid;
  final bool brand;

  const ShopCategoryScreen({Key key, this.cid, this.brand}) : super(key: key);
  @override
  _ShopCategoryScreenState createState() => _ShopCategoryScreenState(brand);
}

class _ShopCategoryScreenState extends State<ShopCategoryScreen> {
  bool box = true;
  bool brand;
  bool filter = false;
  List<String> sortValues = [
    'Sort by'.tr(),
    'High to Low'.tr(),
    'Low to High'.tr()
  ];
  String sortVal = 'Sort by'.tr();
  bool sort = false;
  _ShopCategoryScreenState(this.brand);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/advalogo.png',
                      scale: 3,
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
                                  hintText: 'Search'.tr(),
                                  contentPadding: EdgeInsets.only(
                                      top: screenHeight * 0.01,
                                      left: screenWidth * 0.03),
                                  suffixIcon:
                                      Icon(Icons.search, color: Colors.black)),
                              onSaved: (String value) {},
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: screenWidth * 0.05, top: screenHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        bool applied = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FilterScreen()));
                        if (applied) {
                          setState(() {
                            filter = true;
                          });
                        } else {
                          setState(() {
                            filter = false;
                          });
                        }
                      },
                      child: Container(
                        width: screenWidth * 0.24,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 0.1, color: Colors.black)),
                        child: Row(
                          children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: screenWidth * 0.04,
                                    right: screenWidth * 0.02),
                                child: Text(
                                  'Filter',
                                  style: TextStyle(fontSize: 15),
                                ).tr(),
                              ),
                            ),
                            Icon(Icons.filter_list_outlined),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: Container(
                        width: screenWidth * 0.27,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 0.1, color: Colors.black)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            icon: Icon(
                              Icons.sort,
                              size: 25,
                            ),
                            iconSize: 42,
                            value: sortVal,
                            focusColor: primaryColor,
                            underline: SizedBox(),
                            items: sortValues.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text('$value').tr(),
                              );
                            }).toList(),
                            onChanged: (_) {
                              setState(() {
                                sortVal = _;
                                if (sortVal == sortValues[1]) {
                                  BlocProvider.of<GetSortProductCubit>(context)
                                      .getSortProduct('asc');
                                  setState(() {
                                    sort = true;
                                  });
                                }
                                if (sortVal == sortValues[2]) {
                                  BlocProvider.of<GetSortProductCubit>(context)
                                      .getSortProduct('desc');
                                  setState(() {
                                    sort = true;
                                  });
                                }
                                if (sortVal == sortValues[2]) {
                                  setState(() {
                                    sort = false;
                                  });
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: screenWidth * 0.1,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 0.1, color: Colors.black)),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                box = !box;
                              });
                            },
                            child: !box
                                ? Icon(Icons.widgets_outlined)
                                : Icon(Icons.list)),
                      ),
                    ),
                  ],
                ),
              ),
              //SHOP BY BRAND AND CATEGORY
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02, horizontal: 15),
                child: Container(
                  // screenHeight: screenHeight * 0.26,
                  width: screenWidth,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.01, left: screenWidth * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shop by brand',
                          style: TextStyle(fontSize: 16),
                        ).tr(),
                        SizedBox(height: screenHeight * 0.015),
                        Container(
                          height: screenHeight * 0.08,
                          width: screenWidth,
                          child: BlocBuilder<GetBrandsCubit, BrandState>(
                            builder: (context, state) {
                              if (state is BrandInitialState) {
                                return buildLoading();
                              } else if (state is BrandLoadingState) {
                                return buildLoading();
                              } else if (state is BrandLoadedState) {
                                // print("LIST OF BRANDS : ${state.brands}");
                                if (state.brands == null) {
                                  return Center(
                                      child: CircularProgressIndicator(
                                    backgroundColor: primaryColor,
                                  ));
                                } else {
                                  List<Brand> brands = state.brands;
                                  List<Widget> brandWidgets = [];
                                  for (Brand bnd in brands) {
                                    // print("BRAND ${brand.image}");
                                    brandWidgets.add(
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            brand = true;
                                            filter = false;
                                          });
                                          BlocProvider.of<
                                                      GetBrandProductsCubit>(
                                                  context)
                                              .getBrandProducts(bnd.brandName);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14),
                                          child: ShopSlideContainer(
                                            img: bnd.image,
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  return ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: brandWidgets,
                                  );
                                }
                              } else if (state is BrandErrorState) {
                                return buildErrorUi(state.message);
                              } else {
                                return buildErrorUi('Could not load data.');
                              }
                            },
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.017,
                              bottom: screenHeight * 0.01),
                          child: Text(
                            'Shop by category',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.5),
                          ).tr(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //CATEGORY
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
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
                                    List<Widget> images = [];
                                    for (Category cat in cats) {
                                      images.add(Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              brand = false;
                                              filter = false;
                                            });
                                            BlocProvider.of<
                                                        GetCategoryProductsCubit>(
                                                    context)
                                                .getCategoryProducts(
                                                    cat.id.toString());
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Colors.grey,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            height: 40,
                                            width: 150,
                                            child: Center(
                                              child: Text(
                                                '${context.locale == Locale('en', '') ? cat.categoryName : cat.categoryArabicName}',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
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
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // PRODUCTS
              Container(
                width: double.maxFinite,
                // height: 400,
                child: filter
                    ? BlocBuilder<GetFilterProductCubit, ProductState>(
                        builder: (context, state) {
                          print('INSIDE BRAND');
                          if (state is ProductInitialState) {
                            return buildLoading();
                          } else if (state is ProductLoadingState) {
                            return buildLoading();
                          } else if (state is ProductFilterScreenState) {
                            if (state.products == null) {
                              return Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: primaryColor,
                              ));
                            } else {
                              if (state.products.length == 0) {
                                return buildNotFound();
                              } else
                                return makeProducts(
                                  screenHeight,
                                  state.products,
                                  box,
                                  context,
                                );
                            }
                          } else if (state is ProductErrorState) {
                            return buildErrorUi(state.message);
                          } else {
                            return buildErrorUi('Could not load data.');
                          }
                        },
                      )
                    : (sort
                        ? BlocBuilder<GetSortProductCubit, ProductState>(
                            builder: (context, state) {
                              print('INSIDE Sort');
                              if (state is ProductInitialState) {
                                return buildLoading();
                              } else if (state is ProductLoadingState) {
                                return buildLoading();
                              } else if (state is ProductSortScreenState) {
                                if (state.products == null) {
                                  return Center(
                                      child: CircularProgressIndicator(
                                    backgroundColor: primaryColor,
                                  ));
                                } else {
                                  if (state.products.length == 0) {
                                    return buildNotFound();
                                  } else
                                    return makeProducts(
                                      screenHeight,
                                      state.products,
                                      box,
                                      context,
                                    );
                                }
                              } else if (state is ProductErrorState) {
                                return buildErrorUi(state.message);
                              } else {
                                return buildErrorUi('Could not load data.');
                              }
                            },
                          )
                        : (brand
                            ? BlocConsumer<GetBrandProductsCubit, BrandState>(
                                listener: (context, state) {
                                  if (state is BrandProductsLoadedState) {
                                    setState(() {
                                      brand = true;
                                      print("BRAND $brand");
                                    });
                                  }
                                },
                                builder: (context, state) {
                                  print('INSIDE BRAND');
                                  if (state is BrandInitialState) {
                                    return buildLoading();
                                  } else if (state is BrandLoadingState) {
                                    return buildLoading();
                                  } else if (state
                                      is BrandProductsLoadedState) {
                                    if (state.products == null) {
                                      return Center(
                                          child: CircularProgressIndicator(
                                        backgroundColor: primaryColor,
                                      ));
                                    } else
                                      return makeProducts(
                                        screenHeight,
                                        state.products,
                                        box,
                                        context,
                                      );
                                  } else if (state is BrandErrorState) {
                                    return buildErrorUi(state.message);
                                  } else {
                                    return buildErrorUi('Could not load data.');
                                  }
                                },
                              )
                            : BlocConsumer<GetCategoryProductsCubit,
                                CategoryState>(
                                listener: (context, state) {
                                  if (state is GetCategoryProductsCubit) {
                                    {
                                      setState(() {
                                        brand = false;
                                      });
                                    }
                                  }
                                },
                                builder: (context, state) {
                                  print('INSIDE Category');
                                  if (state is CategoryInitialState) {
                                    return buildLoading();
                                  } else if (state is CategoryLoadingState) {
                                    return buildLoading();
                                  } else if (state
                                      is CategoryProductsLoadedState) {
                                    if (state.products == null) {
                                      return Center(
                                          child: CircularProgressIndicator(
                                        backgroundColor: primaryColor,
                                      ));
                                    } else
                                      return makeProducts(
                                        screenHeight,
                                        state.products,
                                        box,
                                        context,
                                      );
                                  } else if (state is CategoryErrorState) {
                                    return buildErrorUi(state.message);
                                  } else {
                                    return buildErrorUi('Could not load data.');
                                  }
                                },
                              ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopSlideContainer extends StatelessWidget {
  const ShopSlideContainer({
    Key key,
    this.img,
  }) : super(key: key);

  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.14,
      decoration:
          BoxDecoration(border: Border.all(width: 0.3, color: primaryColor)),
      child: FittedBox(
        fit: BoxFit.cover,
        child: img == null
            ? Icon(
                Icons.image,
                color: Colors.grey,
              )
            : Image.network(
                img,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
