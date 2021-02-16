import 'package:adva/data/model/category.dart';
import 'package:adva/data/model/product.dart';
import 'package:equatable/equatable.dart';

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

  CategoryLoadedState({this.category});

  @override
  // TODO: implement props
  List<Object> get props => [category];
}

class CategoryProductsLoadedState extends CategoryState {
  final List<Product> products;

  CategoryProductsLoadedState({this.products});

  @override
  // TODO: implement props
  List<Object> get props => [products];
}

class CategoryErrorState extends CategoryState {
  final String message;

  CategoryErrorState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
