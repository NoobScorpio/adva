import 'package:adva/ui/screens/postViewScreen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class Post extends StatelessWidget {
  final userImage, userName, date, time, comments, likes, bodyImage, bodyText;
  const Post({
    Key key,
    this.userImage,
    this.userName,
    this.date,
    this.time,
    this.comments,
    this.likes,
    this.bodyImage,
    this.bodyText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 25.0, backgroundImage: AssetImage("$userImage")),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    userName,
                    style: boldTextStyle,
                  ),
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
          //IMAGE
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PostViewScreen()));
            },
            child: Container(
              height: 265,
              width: double.maxFinite,
              child:
                  FittedBox(fit: BoxFit.cover, child: Image.asset(bodyImage)),
            ),
          ),
          SizedBox(
            height: 15,
          ),

          if (bodyText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(
                width: double.maxFinite,
                child: Text(bodyText),
              ),
            ),
          // SHARE COMMENT LIKE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
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
                  Text('Comments: $comments'),
                  SizedBox(
                    width: 10,
                  ),
                  // Image.asset('assets/images/comment.png'),
                  Icon(
                    Icons.comment,
                    color: primaryColor,
                  ),
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
                    Text('Likes: $likes'),
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
    );
  }
}
