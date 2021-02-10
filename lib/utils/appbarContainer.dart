import 'package:flutter/material.dart';

class AppbarContainer extends StatelessWidget {
  const AppbarContainer({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.08,
      width: screenWidth,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.1, color: Colors.black),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.arrow_back_ios),
                SizedBox(
                  width: screenWidth * 0.02,
                ),
                Image.asset(
                  'assets/images/advalogo.png',
                  scale: 2,
                ),
              ],
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            Image.asset('assets/images/search.png')
          ],
        ),
      ),
    );
  }
}
