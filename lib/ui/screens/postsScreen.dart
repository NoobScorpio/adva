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

  ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.animateTo(265,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListWheelScrollView(
            itemExtent: 265,
            controller: _scrollController,
            diameterRatio: 3,
            children: [
              testPost("assets/samples/heroes/hero 1.jpg"),
              testPost("assets/samples/heroes/hero 2.jpg"),
              testPost("assets/samples/heroes/hero 3.jpg"),
              testPost("assets/samples/heroes/hero 4.jpg"),
              testPost("assets/samples/heroes/hero 5.jpg"),
              testPost("assets/samples/heroes/hero 6.jpg"),
            ],
          ),
        ),
      ),
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
