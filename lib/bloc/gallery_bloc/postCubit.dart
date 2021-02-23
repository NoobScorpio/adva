import 'dart:io';

import 'package:adva/bloc/gallery_bloc/galleryState.dart';
import 'package:adva/data/repository/galleryRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsCubit extends Cubit<GalleryState> {
  final GalleryRepository galleryRepository;

  PostsCubit({this.galleryRepository}) : super(GalleryInitialState());

  Future<void> getPosts(String filter) async {
    try {
      emit(GalleryLoadingState());
      final posts = await galleryRepository.getPosts(filter: filter);
      emit(GalleryLoadedState(posts: posts));
    } on Exception {
      emit(GalleryErrorState());
    }
  }

  Future<bool> postMedia(File image, String desc, int cid) async {
    try {
      emit(GalleryLoadingState());
      final posts =
          await galleryRepository.postMedia(image: image, desc: desc, cid: cid);
      if (posts != null) {
        emit(GalleryLoadedState(posts: posts));
        return true;
      } else {
        emit(GalleryLoadedState(posts: posts));
        return false;
      }
    } on Exception {
      emit(GalleryErrorState());
      return false;
    }
  }

  Future<bool> postLike(int pid, int cid) async {
    try {
      // emit(GalleryLoadingState());
      final posts = await galleryRepository.postLike(pid: pid, cid: cid);
      if (posts != null) {
        emit(GalleryPostLikedState(posts: posts));
        emit(GalleryLoadedState(posts: posts));
        return true;
      } else {
        emit(GalleryLoadedState(posts: posts));
        return false;
      }
    } on Exception {
      emit(GalleryErrorState());
      return false;
    }
  }
}
