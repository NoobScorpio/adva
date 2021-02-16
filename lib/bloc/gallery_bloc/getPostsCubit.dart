import 'package:adva/bloc/gallery_bloc/galleryState.dart';
import 'package:adva/data/repository/galleryRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetPostsCubit extends Cubit<GalleryState> {
  final GalleryRepository galleryRepository;

  GetPostsCubit({this.galleryRepository}) : super(GalleryInitialState());

  Future<void> getPosts(String filter) async {
    try {
      emit(GalleryLoadingState());
      final posts = await galleryRepository.getPosts(filter: filter);
      emit(GalleryLoadedState(posts: posts));
    } on Exception {
      emit(GalleryErrorState());
    }
  }
}
