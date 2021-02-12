import 'package:adva/bloc/ads_bloc/adsEvent.dart';
import 'package:adva/bloc/ads_bloc/adsState.dart';
import 'package:adva/bloc/category_bloc/categoryEvent.dart';
import 'package:adva/bloc/category_bloc/categoryState.dart';
import 'package:adva/data/model/ads.dart';
import 'package:adva/data/model/category.dart';
import 'package:adva/data/repository/categoryRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc({@required this.repository}) : super(null);

  @override
  // TODO: implement initialState
  CategoryState get initialState => CategoryInitialState();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is FetchCategoryEvent) {
      yield CategoryLoadingState();
      try {
        List<Category> categories = await repository.getCategories();
        yield CategoryLoadedState(category: categories);
      } catch (e) {
        yield CategoryErrorState(message: e);
      }
    }
  }
}
