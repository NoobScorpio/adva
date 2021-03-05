import 'package:adva/ui/utils/white_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    Key key,
    @required this.screenWidth,
    @required this.screenHeight,
    this.padding,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding == null
          ? EdgeInsets.only(
              left: screenWidth * 0.05,
              top: screenHeight * 0.001,
              right: screenWidth * 0.05)
          : padding,
      child: Container(
        height: screenHeight * 0.06,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            WhiteButton(
              screenWidth: screenWidth,
              txt: 'Fashion'.tr(),
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
