import 'package:adva/data/model/category.dart';
import 'package:adva/data/repository/categoryRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

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
        yield CategoryErrorState(message: e.toString());
      }
    }
  }

  @override
  Future<void> close() {}
}

//////////////////////    EVENTS      /////////////////////////////

abstract class CategoryEvent extends Equatable {}

class FetchCategoryEvent extends CategoryEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

//////////////////////    STATES     /////////////////////

abstract class CategoryState extends Equatable {}

class CategoryInitialState extends CategoryState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CategoryLoadingState extends CategoryState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CategoryLoadedState extends CategoryState {
  final List<Category> category;

  CategoryLoadedState({@required this.category});

  @override
  // TODO: implement props
  List<Object> get props => [category];
}

class CategoryErrorState extends CategoryState {
  final String message;

  CategoryErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
