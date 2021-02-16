import 'package:adva/ui/screens/galleryRecentScreen.dart';
import 'package:adva/ui/screens/galleryTopScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';

import 'createPostScreen.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Gallery',
            style: TextStyle(color: Colors.black),
          ),
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  'Top',
                  style: boldTextStyle,
                ),
              ),
              Tab(
                child: Text(
                  'Recent',
                  style: boldTextStyle,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Icon(Icons.directions_car),
            // Icon(Icons.directions_transit),
            GalleryTopScreen(),
            GalleryRecentScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => CreatePostScreen()));
          },
          backgroundColor: primaryColor,
          child: Icon(Icons.add),
        ),
      ), // Complete this code in the next step.
    );
  }
}
