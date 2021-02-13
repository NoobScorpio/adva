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

class ProductLoadedState extends ProductState {
  final List<Product> offer;

  ProductLoadedState({this.offer});

  @override
  // TODO: implement props
  List<Object> get props => [offer];
}

class ProductErrorState extends ProductState {
  final String message;

  ProductErrorState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
