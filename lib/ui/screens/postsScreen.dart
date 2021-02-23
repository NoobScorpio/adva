import 'package:adva/bloc/gallery_bloc/galleryState.dart';
import 'package:adva/bloc/gallery_bloc/postCubit.dart';
import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/post.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatefulWidget {
  final String filter;

  const PostsScreen({Key key, this.filter}) : super(key: key);
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PostsCubit>(context).getPosts(widget.filter);
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
}
