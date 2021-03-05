import 'package:adva/ui/screens/categoryScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoriesScreen extends StatefulWidget {
  final sharedPreferences;

  const CategoriesScreen({Key key, this.sharedPreferences}) : super(key: key);
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: screenHeight * 0.09,
            width: screenWidth,
            color: Colors.white.withOpacity(0.9),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Row(
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
                                    Image.asset('assets/images/search.png')),
                            onSaved: (String value) {},
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: screenWidth * 0.25,
                  height: screenHeight,
                  color: sideContainerColor,
                  child: CategoriesSideContainer()),
              Container(child: CategoryCustomColumns()),
            ],
          )
        ],
      ),
    );
  }
}

class CategoryCustomColumns extends StatefulWidget {
  @override
  _CategoryCustomColumnsState createState() => _CategoryCustomColumnsState();
}

class _CategoryCustomColumnsState extends State<CategoryCustomColumns> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top brands',
            style: TextStyle(fontSize: 17),
          ).tr(),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          CategoryRow(),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          CategoryRow(),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          CategoryRow(),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          CategoryRow(),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          CategoryRow(),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          CategoryRow(),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          CategoryRow(),
        ],
      ),
    );
  }
}

class CategoryRow extends StatelessWidget {
  // CatergoryRow({this.});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CategoryCard(
          image: 'assets/images/melia.png',
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        ),
        CategoryCard(
          image: 'assets/images/beautybar.png',
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        ),
        CategoryCard(
          image: 'assets/images/melia.png',
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  CategoryCard({this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ShopCategoryScreen()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.215,
        decoration:
            BoxDecoration(border: Border.all(width: 0.3, color: primaryColor)),
        child: FittedBox(
          child: Image.asset(
            image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class CategoriesSideContainer extends StatefulWidget {
  @override
  _CategoriesSideContainerState createState() =>
      _CategoriesSideContainerState();
}

class _CategoriesSideContainerState extends State<CategoriesSideContainer> {
  Color activeColor = Colors.white;
  Color inactiveColor = sideContainerColor;
  List<bool> buttonBools = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < categoryListStrings.length; i++) {
      if (i == 0)
        buttonBools.add(true);
      else
        buttonBools.add(false);
    }
  }

  void setBool(int index) {
    for (int i = 0; i < categoryListStrings.length; i++) {
      if (i == index)
        setState(() {
          buttonBools[i] = true;
        });
      else
        setState(() {
          buttonBools[i] = false;
        });
    }
  }

  _CategoriesSideContainerState();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categoryListStrings.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print("PRESSED 0");
            setBool(index);
          },
          child: Container(
            color: buttonBools[index] ? activeColor : inactiveColor,
            height: MediaQuery.of(context).size.width * 0.13,
            child: Center(
              child: Text(categoryListStrings[index]),
            ),
          ),
        );
      },
    );
  }
}
