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
    );
  }
}

class Post extends StatelessWidget {
  final userImage, userName, date, time, comments, likes, bodyImage;
  const Post({
    Key key,
    this.userImage,
    this.userName,
    this.date,
    this.time,
    this.comments,
    this.likes,
    this.bodyImage,
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
                      radius: 30.0, backgroundImage: AssetImage(userImage)),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    userImage,
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
          Container(
            child: Image.asset(bodyImage),
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
                  Text('Comments: $comments'),
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
    );
  }
}

class Comment extends StatelessWidget {
  final image, name, body;
  const Comment({
    Key key,
    this.image,
    this.name,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(radius: 25.0, backgroundImage: AssetImage(image)),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              width: double.maxFinite,
              color: commentBGColor,
              height: 75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: boldTextStyle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    body,
                    style: normalTextStyle,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
