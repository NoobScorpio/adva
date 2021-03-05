import 'dart:convert';
import 'dart:io';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/screens/galleryRecentScreen.dart';
import 'package:adva/ui/screens/postsScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
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
          automaticallyImplyLeading: false,
          title: Text(
            'Gallery',
            style: TextStyle(color: Colors.black),
          ).tr(),
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  'Top',
                  style: boldTextStyle,
                ).tr(),
              ),
              Tab(
                child: Text(
                  'Recent',
                  style: boldTextStyle,
                ).tr(),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Icon(Icons.directions_car),
            // Icon(Icons.directions_transit),
            PostsScreen(filter: "top".tr()),
            PostsScreen(filter: "recent".tr()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              SharedPreferences sp = await SharedPreferences.getInstance();
              List<Media> res = await ImagesPicker.pick(
                count: 1,
                pickType: PickType.image,
              );
              if (res != null && res.length > 0) {
                File image = File(res[0].path);
                List<int> imageBytes = image.readAsBytesSync();
                String baseImage = base64Encode(imageBytes);
                print(baseImage.split('/'));
                // User user = User.fromJson(json.decode(sp.getString('user')));
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (_) =>
                //             CreatePostScreen(image: image, user: user)));
                //
                // print("UPDATED");
              }
            } catch (e) {
              print(e);
              showToast("Something went wrong", primaryColor);
            }
          },
          backgroundColor: primaryColor,
          child: Icon(Icons.add),
        ),
      ), // Complete this code in the next step.
    );
  }
}
