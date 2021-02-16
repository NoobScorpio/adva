import 'package:adva/data/model/brand.dart';
import 'package:adva/data/model/product.dart';
import 'package:equatable/equatable.dart';

abstract class BrandState extends Equatable {}

class BrandInitialState extends BrandState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BrandLoadingState extends BrandState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BrandLoadedState extends BrandState {
  final List<Brand> brands;

  BrandLoadedState({this.brands});

  @override
  // TODO: implement props
  List<Object> get props => [brands];
}

class BrandErrorState extends BrandState {
  final String message;

  BrandErrorState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class BrandProductsLoadedState extends BrandState {
  final List<Product> products;

  BrandProductsLoadedState({this.products});

  @override
  // TODO: implement props
  List<Object> get props => [products];
}
