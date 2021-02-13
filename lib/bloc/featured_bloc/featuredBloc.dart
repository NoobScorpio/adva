import 'package:adva/bloc/featured_bloc/featuredEvent.dart';
import 'package:adva/bloc/featured_bloc/featuredState.dart';
import 'package:adva/data/model/featured.dart';
import 'package:adva/data/repository/featuredRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedBloc extends Bloc<FeaturedEvent, FeaturedState> {
  final FeaturedRepository repository;

  FeaturedBloc({@required this.repository}) : super(null);

  // TODO: implement initialState
  FeaturedState get initialState => FeaturedInitialState();

  @override
  Stream<FeaturedState> mapEventToState(FeaturedEvent event) async* {
    if (event is FetchFeaturedEvent) {
      yield FeaturedLoadingState();
      try {
        List<Featured> offers = await repository.getFeatured();
        yield FeaturedLoadedState(featured: offers);
      } catch (e) {
        yield FeaturedErrorState(message: e.toString());
      }
    }
  }
}
