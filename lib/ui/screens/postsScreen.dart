import 'dart:async';
import 'dart:convert';

import 'package:adva/bloc/gallery_bloc/galleryState.dart';
import 'package:adva/bloc/gallery_bloc/postCubit.dart';
import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/data/model/comment.dart';
import 'package:adva/data/model/like.dart';
import 'package:adva/data/model/post.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/repository/galleryRepo.dart';
import 'package:adva/ui/utils/comment.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/post.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostsScreen extends StatefulWidget {
  // final String filter;
  // const PostsScreen({Key key, this.filter}) : super(key: key);
  final List<PostModel> posts;
  final int selected;
  final User user;
  const PostsScreen({Key key, this.posts, this.selected, this.user})
      : super(key: key);
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // BlocProvider.of<PostsCubit>(context).getPosts(widget.filter);
  }

  CarouselController buttonCarouselController = CarouselController();

  getWidgets({height}) async {
    // print("@HEIGHT $height");
    int postOuterId = 0;
    List<Widget> widgets = [];
    for (PostModel post in widget.posts) {
      int likes = post.likesCount;
      int postLikes = post.likesCount;
      widgets.add(StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              elevation: 6,
              child: Column(
                children: [
                  Container(
                    height: height * 0.38,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(post.image))),
                  ),
                  Expanded(
                    child: Container(
                      // height: height * 0.15,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${post.description}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      showToast("Sending Like", primaryColor);
                                      SharedPreferences sp =
                                          await SharedPreferences.getInstance();
                                      bool loggedIn = sp.getBool('loggedIn');
                                      if (loggedIn == null ||
                                          loggedIn == false) {
                                        showToast(
                                            "Not logged in", primaryColor);
                                      } else {
                                        User user =
                                            await BlocProvider.of<UserCubit>(
                                                    context)
                                                .getUser();

                                        List<PostModel> postLiked =
                                            await BlocProvider.of<PostsCubit>(
                                                    context)
                                                .postLike(post.id, user.id);

                                        if (postLiked != null) {
                                          print("@ POSTS NOT NULL");
                                          for (PostModel innerPost
                                              in postLiked) {
                                            if (innerPost.id == post.id) {
                                              if (innerPost.likesCount <
                                                  likes) {
                                                print("@ POST LIKED");
                                                showToast(
                                                    "Un liked", primaryColor);
                                                setState(() {
                                                  post.likesCount =
                                                      innerPost.likesCount;
                                                });
                                              } else {
                                                print("@ POST UN LIKED");
                                                showToast(
                                                    "Liked", primaryColor);
                                                setState(() {
                                                  post.likesCount =
                                                      innerPost.likesCount;
                                                });
                                              }
                                            }
                                          }
                                        } else
                                          showToast(
                                              "Could not like", primaryColor);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.thumb_up_alt,
                                          color: secondaryColor,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${post.likesCount}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      List<Widget> commentWidgets = [];
                                      for (Comments comment in post.comments) {
                                        commentWidgets.add(Comment(
                                            image: comment.customer == null
                                                ? null
                                                : comment.customer.profileImage,
                                            body: comment.comment,
                                            name: comment.customer == null
                                                ? null
                                                : comment.customer.firstName +
                                                    " " +
                                                    comment.customer.lastName));
                                      }
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter
                                                        setState /*You can rename this!*/) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: ListView(
                                                        children:
                                                            commentWidgets,
                                                      ),
                                                    ),
                                                    Container(
                                                      // color: Colors.black,
                                                      width: double.maxFinite,
                                                      height: height * 0.12,

                                                      child: Card(
                                                        elevation: 5,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                  child:
                                                                      TextField(
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      'Type your comment here'
                                                                          .tr(),
                                                                  suffix:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () async {
                                                                      showToast(
                                                                          "Posting comment",
                                                                          primaryColor);
                                                                      SharedPreferences
                                                                          sp =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      bool
                                                                          loggedIn =
                                                                          sp.getBool(
                                                                              'loggedIn');

                                                                      if (loggedIn ==
                                                                              null ||
                                                                          !loggedIn) {
                                                                        showToast(
                                                                            "Not logged in",
                                                                            primaryColor);
                                                                      } else {
                                                                        User
                                                                            user =
                                                                            User.fromJson(json.decode(sp.getString('user')));
                                                                        if (user.id ==
                                                                            null)
                                                                          showToast(
                                                                              "Log in again to comment",
                                                                              primaryColor);
                                                                        else {
                                                                          if (commentController.text ==
                                                                              '') {
                                                                            showToast("Write something to post",
                                                                                primaryColor);
                                                                          } else {
                                                                            bool
                                                                                commented =
                                                                                await GalleryRepositoryImpl().postComment(pid: post.id, cid: user.id, comment: commentController.text);
                                                                            if (commented) {
                                                                              setState(() {
                                                                                commentWidgets.add(Comment(
                                                                                  name: user.firstName + " " + user.lastName,
                                                                                  body: commentController.text,
                                                                                ));
                                                                                post.comments.length += 1;
                                                                              });
                                                                              // sheetSetState(() {
                                                                              //   sheetComments.add(Comment(
                                                                              //     name: user.firstName + " " + user.lastName,
                                                                              //     body: commentController.text,
                                                                              //   ));
                                                                              // });
                                                                              commentController.text = '';
                                                                              BlocProvider.of<PostsCubit>(context).getPosts('');
                                                                            } else {
                                                                              showToast("Something went wrong", primaryColor);
                                                                            }
                                                                          }
                                                                        }
                                                                      }
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .send,
                                                                      color:
                                                                          primaryColor,
                                                                    ),
                                                                  ),
                                                                  border: OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: Colors.black)),
                                                                ),
                                                                controller:
                                                                    commentController,
                                                              )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                          });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.comment,
                                          color: secondaryColor,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          post.comments.length.toString(),
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await FlutterShare.share(
                                        title: 'ADVA',
                                        text:
                                            'Do check out this amazing post, visit the link below',
                                        linkUrl:
                                            'https://advabeauty.com/gallery',
                                      );
                                    },
                                    child: Icon(
                                      Icons.share,
                                      color: secondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }));
    }
    setState(() {
      items = widgets;
      isLoading = false;
      // buttonCarouselController.jumpToPage(widget.selected);
    });
    // Timer(Duration(seconds: 3),
    //     () => buttonCarouselController.);
  }

  bool isLoading = true;
  List<Widget> items = [];
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => getWidgets(height: MediaQuery.of(context).size.height));
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: primaryColor,
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      primaryColor,
                      primaryColorDark,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: CarouselSlider(
                items: items,
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    height: 400.0,
                    initialPage: widget.selected),
              )),
    );
    Scaffold(
      backgroundColor: commentBGColor,
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          BlocBuilder<PostsCubit, GalleryState>(builder: (context, state) {
            if (state is GalleryInitialState) {
              return buildLoading();
            } else if (state is GalleryLoadingState) {
              return buildLoading();
            } else if (state is GalleryLoadedState) {
              if (state.posts == null) {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                ));
              } else {
                var posts = state.posts;
                List<Widget> widts = [];
                print("POSTS ${posts.length} ");
                for (int i = 0; i < posts.length; i++) {
                  print("profile ");
                  widts.add(Container(
                    height: 430,
                    width: double.maxFinite,
                    // color: Colors.white,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Post(
                            post: posts[i],
                            filter: 'top',
                            push: true,
                            like: null),
                      ),
                    ),
                  ));
                }
                widts.add(SizedBox(
                  height: 300,
                ));
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: widts,
                  ),
                );
              }
            } else if (state is GalleryErrorState) {
              return buildErrorUi(state.message ?? "");
            } else {
              return buildErrorUi('Could not load data.');
            }
          }),
        ],
      ),
    );
  }

  Widget testPost(img) {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(img),
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        Center(
          child: Container(
            height: 50,
            width: 180,
            color: Colors.white.withOpacity(0.6),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/samples/heroes/hero 1.jpg'),
                      // child: Center(
                      //     child: Icon(
                      //   Icons.person,
                      //   color: primaryColor,
                      // ))
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'John Doe',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
