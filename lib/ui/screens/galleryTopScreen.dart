import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/post.dart';
import 'package:flutter/material.dart';

class GalleryTopScreen extends StatefulWidget {
  @override
  _GalleryTopScreenState createState() => _GalleryTopScreenState();
}

class _GalleryTopScreenState extends State<GalleryTopScreen> {
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
                    bodyText: null,
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
                    bodyText: null,
                    bodyImage: 'assets/images/advabeauty.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
