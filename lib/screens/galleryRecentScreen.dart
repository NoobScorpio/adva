import 'package:adva/utils/constants.dart';
import 'package:adva/utils/post.dart';
import 'package:flutter/material.dart';

class GalleryRecentScreen extends StatefulWidget {
  @override
  _GalleryRecentScreenState createState() => _GalleryRecentScreenState();
}

class _GalleryRecentScreenState extends State<GalleryRecentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: commentBGColor,
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 400,
            width: double.maxFinite,
            // color: Colors.white,
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Post(
                    userImage: 'assets/images/advabeauty.png',
                    userName: 'John Doe',
                    date: 'Today',
                    time: '12:45 PM',
                    comments: '30',
                    likes: '30',
                    bodyImage: 'assets/images/advabeauty.png'),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 400,
            width: double.maxFinite,
            // color: Colors.white,
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Post(
                    userImage: 'assets/images/advabeauty.png',
                    userName: 'John Doe',
                    date: 'Today',
                    time: '12:45 PM',
                    comments: '30',
                    likes: '30',
                    bodyImage: 'assets/images/advabeauty.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
