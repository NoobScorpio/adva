import 'package:adva/ui/utils/basic_app_bar.dart';
import 'package:adva/ui/utils/comment.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/makeComments.dart';
import 'package:adva/ui/utils/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostViewScreen extends StatefulWidget {
  final userImage,
      userName,
      date,
      time,
      comments,
      likes,
      bodyImage,
      bodyText,
      commentsList;

  const PostViewScreen({
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
  _PostViewScreenState createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  List<Widget> comments = [];

  @override
  Widget build(BuildContext context) {
    comments = makeComments(widget.commentsList);
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
                      userImage: widget.userImage,
                      userName: widget.userName,
                      date: widget.date,
                      comments: widget.comments,
                      commentsList: widget.commentsList,
                      likes: widget.likes,
                      bodyText: widget.bodyText,
                      bodyImage: widget.bodyImage),
                  SizedBox(
                    height: 20,
                  ),
                  if (widget.commentsList.length > 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: comments,
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
                          onPressed: () {
                            setState(() {
                              comments.add(Comment(
                                name: "Mobile",
                                body: "Mobile comment",
                              ));
                            });
                            setState(() {});
                          },
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
