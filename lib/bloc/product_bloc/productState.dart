import 'package:adva/data/model/product.dart';
import 'package:equatable/equatable.dart';

//////////////////////    STATES     /////////////////////

abstract class ProductState extends Equatable {}

class ProductInitialState extends ProductState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProductLoadingState extends ProductState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProductsLoadedState extends ProductState {
  final List<Product> product;

  ProductsLoadedState({this.product});

  @override
  // TODO: implement props
  List<Object> get props => [product];
}

class ProductLoadedState extends ProductState {
  final Product product;

  ProductLoadedState({this.product});

  @override
  // TODO: implement props
  List<Object> get props => [product];
}

class ProductErrorState extends ProductState {
  final String message;

  ProductErrorState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class ProductPostQuestionState extends ProductState {
  final bool posted;

  ProductPostQuestionState({this.posted});

  @override
  // TODO: implement props
  List<Object> get props => [posted];
}

class ProductPostQuestionScreenState extends ProductState {
  final bool posted;

  ProductPostQuestionScreenState({this.posted});

  @override
  // TODO: implement props
  List<Object> get props => [posted];
}

class ProductPostReviewState extends ProductState {
  final dynamic posted;

  ProductPostReviewState({this.posted});

  @override
  // TODO: implement props
  List<Object> get props => [posted];
}

class ProductPostReviewScreenState extends ProductState {
  final dynamic posted;

  ProductPostReviewScreenState({this.posted});

  @override
  // TODO: implement props
  List<Object> get props => [posted];
}

class ProductFilterScreenState extends ProductState {
  final List<Product> products;

  ProductFilterScreenState({this.products});

  @override
  // TODO: implement props
  List<Object> get props => [products];
}

class ProductSortScreenState extends ProductState {
  final List<Product> products;

  ProductSortScreenState({this.products});

  @override
  // TODO: implement props
  List<Object> get props => [products];
}
