import 'package:adva/bloc/featured_bloc/featuredState.dart';
import 'package:adva/data/model/featured.dart';
import 'package:adva/data/repository/featuredRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetFeaturedCubit extends Cubit<FeaturedState> {
  final FeaturedRepository featuredRepository;

  GetFeaturedCubit({this.featuredRepository}) : super(FeaturedInitialState());

  Future<List<Featured>> getSellers() async {
    try {
      emit(FeaturedLoadingState());
      final featured = await featuredRepository.getFeatured();
      emit(FeaturedLoadedState(featured: featured));
      return featured;
    } on Exception {
      emit(FeaturedErrorState(message: "Could not get featured Items"));
      return null;
    }
  }
}
