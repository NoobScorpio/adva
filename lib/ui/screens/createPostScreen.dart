import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
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
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Create Post',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      suffix: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.send,
                          color: primaryColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    // autofillHints: ['Type your comment here'],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: screenWidth,
                      // height: screenHeight * 0.6,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Image.asset(
                          'assets/images/post.png',
                        ),
                      )),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  MyButton(
                    borderColor: Colors.transparent,
                    innerColor: primaryColor,
                    height: 60,
                    width: screenWidth,
                    child: Text(
                      'Post',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
