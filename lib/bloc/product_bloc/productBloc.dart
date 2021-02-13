import 'package:adva/bloc/product_bloc/productEvent.dart';
import 'package:adva/bloc/product_bloc/productState.dart';
import 'package:adva/data/model/product.dart';
import 'package:adva/data/repository/productRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({@required this.repository}) : super(null);

  @override
  // TODO: implement initialState
  ProductState get initialState => ProductInitialState();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProductEvent) {
      yield ProductLoadingState();
      try {
        List<Product> products = await repository.getProducts();
        yield ProductLoadedState(offer: products);
      } catch (e) {
        yield ProductErrorState(message: e.toString());
      }
    }
    if (event is FetchCategoryProductEvent) {
      yield ProductLoadingState();
      try {
        List<Product> products =
            await repository.getCategoryProducts(event.catName);
        yield ProductLoadedState(offer: products);
      } catch (e) {
        yield ProductErrorState(message: e.toString());
      }
    }
  }
}
