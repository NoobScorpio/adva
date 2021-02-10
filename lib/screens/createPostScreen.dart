import 'package:adva/utils/constants.dart';
import 'package:adva/utils/primaryButton.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.035,
                      right: screenWidth * 0.07,
                    ),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    'Create post',
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                width: screenWidth * 0.93,
                height: screenHeight * 0.12,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.7, color: cartTextColor)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Text(
                    'Description',
                    style: TextStyle(color: cartTextColor),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.035,
                    right: screenWidth * 0.035,
                    top: screenHeight * 0.02),
                child: Container(
                    width: screenWidth,
                    // height: screenHeight * 0.6,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Image.asset(
                        'assets/images/post.png',
                      ),
                    )),
              ),
              SizedBox(
                height: screenHeight * 0.025,
              ),
              PrimaryButton(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                txt: 'Post',
                onpressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
