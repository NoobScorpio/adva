import 'package:adva/utils/basic_app_bar.dart';
import 'package:adva/utils/comment.dart';
import 'package:adva/utils/constants.dart';
import 'package:adva/utils/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostViewScreen extends StatefulWidget {
  @override
  _PostViewScreenState createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  @override
  Widget build(BuildContext context) {
    double sH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: buildAppBar(context, text: 'Gallery'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  Post(
                      userImage: 'assets/images/advabeauty.png',
                      userName: 'John Doe',
                      date: 'Today',
                      time: '12:45 PM',
                      comments: '30',
                      likes: '30',
                      bodyImage: 'assets/images/advabeauty.png'),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: sH * 0.5,
                    child: ListView(
                      children: [
                        Comment(
                            image: 'assets/images/advabeauty.png',
                            body:
                                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut',
                            name: 'John Doe'),
                        Comment(
                            image: 'assets/images/advabeauty.png',
                            body:
                                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut',
                            name: 'John Doe'),
                        Comment(
                            image: 'assets/images/advabeauty.png',
                            body:
                                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut',
                            name: 'John Doe'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            // color: Colors.black,
            width: double.maxFinite,
            height: sH * 0.12,

            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type your comment here',
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
                    )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
