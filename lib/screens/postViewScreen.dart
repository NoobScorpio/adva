import 'package:adva/utils/basic_app_bar.dart';
import 'package:adva/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostViewScreen extends StatefulWidget {
  @override
  _PostViewScreenState createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, text: 'Gallery'),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: AssetImage(
                                      'assets/images/advabeauty.png')),
                              SizedBox(
                                width: 15,
                              ),
                              Text('John Doe'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text('Today'), Text('12:45 PM')],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Image.asset('assets/images/advabeauty.png'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Share'),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.share,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              width: 1,
                              height: 25,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Comments: 30'),
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset('assets/images/comment.png'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              width: 1,
                              height: 25,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Likes: 30'),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.thumb_up,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
