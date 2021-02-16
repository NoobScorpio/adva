import 'package:adva/data/model/comment.dart';
import 'package:adva/ui/screens/postViewScreen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class Post extends StatelessWidget {
  final userImage, userName, date, time, comments, likes, bodyImage, bodyText;
  final List<Comments> commentsList;

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
    this.commentsList,
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
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      userImage,
                    ),
                  ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('$date')],
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostViewScreen(
                            userImage: userImage,
                            userName: userName,
                            date: date,
                            time: time,
                            comments: comments,
                            likes: likes,
                            bodyImage: bodyImage,
                            bodyText: bodyText,
                            commentsList: commentsList,
                          )));
            },
            child: Container(
              height: 265,
              width: double.maxFinite,
              child:
                  FittedBox(fit: BoxFit.cover, child: Image.network(bodyImage)),
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
                child: Text(
                  bodyText,
                  overflow: TextOverflow.ellipsis,
                ),
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
                    //TODO : SHARE FUNCTIONALITY
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
                  //TODO : COMMENT FUNCTIONALITY
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
                    GestureDetector(
                      onTap: () {
                        //TODO : LIKE FUNCTIONALITY
                      },
                      child: Icon(
                        Icons.thumb_up,
                        color: primaryColor,
                      ),
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
