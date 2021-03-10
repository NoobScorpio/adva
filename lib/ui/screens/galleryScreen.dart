import 'dart:convert';
import 'package:adva/bloc/gallery_bloc/galleryState.dart';
import 'package:adva/bloc/gallery_bloc/postCubit.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/screens/postsScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PostsCubit>(context).getPosts('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 45),
              child: Text(
                'Gallery',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ).tr(),
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: BlocBuilder<PostsCubit, GalleryState>(
                builder: (context, state) {
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
                  List<Widget> widgets = [];

                  for (int i = 0; i < posts.length; i++) {
                    widgets.add(InkWell(
                      onTap: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        bool loggedIn = sp.getBool('loggedIn');
                        if (loggedIn) {
                          String userStr = sp.getString('user');
                          if (userStr != null && userStr != '') {
                            User user = User.fromJson(json.decode(userStr));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PostsScreen(
                                        posts: posts,
                                        selected: i,
                                        user: user)));
                          }
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PostsScreen(
                                      posts: posts, selected: i, user: null)));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(posts[i].image),
                            )),
                      ),
                    ));
                  }
                  return GridView.count(
                    crossAxisCount: 3,
                    padding: const EdgeInsets.all(15),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    // childAspectRatio: screenHeight * 0.00069,
                    children: widgets,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  );
                }
              } else if (state is GalleryErrorState) {
                return buildErrorUi(state.message ?? "");
              } else {
                return buildErrorUi('Could not load data.');
              }
            }),
          ))
        ],
      ),
    );
  }
}
