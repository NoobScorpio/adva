import 'package:adva/data/model/post.dart';
import 'package:equatable/equatable.dart';

abstract class GalleryState extends Equatable {}

class GalleryInitialState extends GalleryState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GalleryLoadingState extends GalleryState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GalleryLoadedState extends GalleryState {
  final List<PostModel> posts;

  GalleryLoadedState({this.posts});

  @override
  // TODO: implement props
  List<Object> get props => [posts];
}

class GalleryPostLikedState extends GalleryState {
  final List<PostModel> posts;

  GalleryPostLikedState({this.posts});

  @override
  // TODO: implement props
  List<Object> get props => [posts];
}

class GalleryErrorState extends GalleryState {
  final String message;

  GalleryErrorState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
