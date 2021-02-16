import 'package:adva/bloc/gallery_bloc/galleryState.dart';
import 'package:adva/bloc/gallery_bloc/getPostsCubit.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/post.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryRecentScreen extends StatefulWidget {
  @override
  _GalleryRecentScreenState createState() => _GalleryRecentScreenState();
}

class _GalleryRecentScreenState extends State<GalleryRecentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetPostsCubit>(context).getPosts('recent');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: commentBGColor,
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          BlocBuilder<GetPostsCubit, GalleryState>(builder: (context, state) {
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
                  widts.add(Container(
                    height: 430,
                    width: double.maxFinite,
                    // color: Colors.white,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Post(
                            userImage: posts[i].customer.profileImage,
                            userName: posts[i].customer.firstName +
                                ' ' +
                                posts[i].customer.lastName,
                            date: posts[i].createdAt,
                            comments: posts[i].comments.length,
                            commentsList: posts[i].comments,
                            likes: posts[i].likes.length,
                            bodyText: posts[i].description,
                            bodyImage: posts[i].image),
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
              return buildErrorUi(state.message);
            } else {
              return buildErrorUi('Could not load data.');
            }
          }),
        ],
      ),
    );
  }
}
