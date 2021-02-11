import 'package:adva/utils/constants.dart';
import 'package:adva/utils/primaryButton.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int _value;
  int _value1;
  int _value2;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
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
                            'Product Categories',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                        ),
                        for (int i = 1; i <= 3; i++)
                          ListTile(
                            title: Text(
                              'Product $i',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      color: i == 3
                                          ? Colors.black38
                                          : Colors.black),
                            ),
                            leading: Radio(
                              value: i,
                              groupValue: _value,
                              activeColor: primaryColor,
                              onChanged: i == 4
                                  ? null
                                  : (int value) {
                                      setState(() {
                                        _value = value;
                                      });
                                    },
                            ),
                          ),
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
                            'Latest Products',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                        ),
                        for (int i = 1; i <= 4; i++)
                          ListTile(
                            title: Text(
                              'Product $i',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      color: i == 5
                                          ? Colors.black38
                                          : Colors.black),
                            ),
                            leading: Radio(
                              value: i,
                              groupValue: _value1,
                              activeColor: primaryColor,
                              onChanged: i == 5
                                  ? null
                                  : (int value) {
                                      setState(() {
                                        _value1 = value;
                                      });
                                    },
                            ),
                          ),
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
                            'Latest Products',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                        ),
                        for (int i = 1; i <= 4; i++)
                          ListTile(
                            title: Text(
                              'Product $i',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      color: i == 5
                                          ? Colors.black38
                                          : Colors.black),
                            ),
                            leading: Radio(
                              value: i,
                              groupValue: _value2,
                              activeColor: primaryColor,
                              onChanged: i == 5
                                  ? null
                                  : (int value) {
                                      setState(() {
                                        _value2 = value;
                                      });
                                    },
                            ),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.09,
                            right: screenWidth * 0.01,
                          ),
                          child: Container(
                            width: screenWidth * 0.27,
                            height: screenHeight * 0.047,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.1, color: Colors.black)),
                            child: Center(
                              child: Text(
                                'Clear',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        PrimaryButton(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth * 0.57,
                          txt: 'Apply',
                          onpressed: () {},
                        )
                      ],
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
    );
  }
}
