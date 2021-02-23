import 'dart:convert';

import 'package:adva/bloc/gallery_bloc/postCubit.dart';
import 'package:adva/data/model/post.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/repository/galleryRepo.dart';
import 'package:adva/ui/utils/basic_app_bar.dart';
import 'package:adva/ui/utils/comment.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/makeComments.dart';
import 'package:adva/ui/utils/post.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostViewScreen extends StatefulWidget {
  final PostModel post;
  final String filter;
  const PostViewScreen({Key key, this.post, this.filter}) : super(key: key);
  @override
  _PostViewScreenState createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  List<Widget> comments = [];
  PostModel post;
  TextEditingController commentController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    post = widget.post;
    comments = makeComments(post.comments);
    commentController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    commentController.dispose();
  }

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
                    post: post,
                    filter: widget.filter,
                    push: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (post.comments.length > 0)
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
                          onPressed: () async {
                            showToast("Posting comment", primaryColor);
                            SharedPreferences sp =
                                await SharedPreferences.getInstance();
                            bool loggedIn = sp.getBool('loggedIn');

                            if (loggedIn == null || !loggedIn) {
                              showToast("Not logged in", primaryColor);
                            } else {
                              User user = User.fromJson(
                                  json.decode(sp.getString('user')));
                              if (user.id == null)
                                showToast(
                                    "Log in again to comment", primaryColor);
                              else {
                                if (commentController.text == '') {
                                  showToast(
                                      "Write something to post", primaryColor);
                                } else {
                                  bool commented = await GalleryRepositoryImpl()
                                      .postComment(
                                          pid: post.id,
                                          cid: user.id,
                                          comment: commentController.text);
                                  if (commented) {
                                    setState(() {
                                      comments.add(Comment(
                                        name: user.firstName +
                                            " " +
                                            user.lastName,
                                        body: commentController.text,
                                      ));
                                    });
                                    commentController.text = '';
                                    BlocProvider.of<PostsCubit>(context)
                                        .getPosts(widget.filter);
                                  } else {
                                    showToast(
                                        "Something went wrong", primaryColor);
                                  }
                                }
                              }
                            }
                          },
                          icon: Icon(
                            Icons.send,
                            color: primaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                      controller: commentController,
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
