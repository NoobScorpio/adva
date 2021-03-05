import 'dart:convert';

import 'package:adva/bloc/gallery_bloc/postCubit.dart';
import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/data/model/like.dart';
import 'package:adva/data/model/post.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/screens/postViewScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Post extends StatefulWidget {
  final PostModel post;
  final String filter;
  final bool push, like;
  const Post({
    Key key,
    this.post,
    this.filter,
    this.push,
    this.like,
  }) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  PostModel post;
  bool liked = false;
  int likes = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    post = widget.post;
    likes = post.likes.length;
    getLiked();
  }

  getLiked() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    User user = User.fromJson(json.decode(sp.getString('user')));
    if (user != null && user.id != null) {
      for (Likes likes in post.likes) {
        if (likes.customerId == user.id) {
          setState(() {
            liked = true;
          });
        }
      }
    }
    if (widget.like != null)
      setState(() {
        liked = widget.like;
      });
  }

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
                  if (post.customer == null)
                    CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  if (post.customer != null)
                    if (post.customer.profileImage != null)
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                          post.customer.profileImage,
                        ),
                      ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    post.customer != null
                        ? post.customer.firstName + " " + post.customer.lastName
                        : "Anonymous",
                    style: boldTextStyle,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('${post.createdAt}')],
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
              if (widget.push)
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostViewScreen(
                            post: post, filter: widget.filter, liked: liked)));
            },
            child: Container(
              height: 265,
              width: double.maxFinite,
              child: FittedBox(
                  fit: BoxFit.cover, child: Image.network(post.image)),
            ),
          ),
          SizedBox(
            height: 15,
          ),

          if (post.description != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(
                width: double.maxFinite,
                child: Text(
                  post.description,
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
                    GestureDetector(
                      onTap: () async {
                        const url =
                            "whatsapp://send?text=Do check out this amazing post, visit https://advabeauty.com/gallery for more";
                        if (await canLaunch(url)) {
                          await launch(url);
                        }
                      },
                      child: Icon(
                        Icons.share,
                        color: primaryColor,
                      ),
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
                  Text('Comments: ${post.comments.length}'),
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
                      onTap: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        bool loggedIn = sp.getBool('loggedIn');
                        if (loggedIn == null || loggedIn == false) {
                          showToast("Not logged in", primaryColor);
                        } else {
                          User user = await BlocProvider.of<UserCubit>(context)
                              .getUser();
                          // print("CUSTOEMR ID: ${user.id}");
                          bool postLiked =
                              await BlocProvider.of<PostsCubit>(context)
                                  .postLike(post.id, user.id);
                          if (postLiked) {
                            if (liked) {
                              setState(() {
                                liked = false;
                                likes--;
                              });
                              showToast("Unliked", primaryColor);
                            } else if (!liked) {
                              setState(() {
                                liked = true;
                                likes++;
                              });
                              showToast("Liked", primaryColor);
                            }
                          } else
                            showToast("Coulnot like", primaryColor);
                        }
                      },
                      child: liked
                          ? Icon(
                              Icons.thumb_up,
                              color: primaryColor,
                            )
                          : Icon(
                              Icons.thumb_up_alt_outlined,
                              color: primaryColor,
                            ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class LikeButton extends StatelessWidget {
  final like, pid, likes;

  const LikeButton({Key key, this.like, this.pid, this.likes})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Likes: $likes'),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () async {
              User user = await BlocProvider.of<UserCubit>(context).getUser();
              print("CUSTOEMR ID: ${user.id}");
              bool liked = await BlocProvider.of<PostsCubit>(context)
                  .postLike(pid, user.id);
            },
            child: like
                ? Icon(
                    Icons.thumb_up,
                    color: primaryColor,
                  )
                : Icon(
                    Icons.thumb_up_alt_outlined,
                    color: primaryColor,
                  ),
          )
        ],
      ),
    );
  }
}
