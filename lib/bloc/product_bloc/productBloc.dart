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
    print('INSIDE PRODUCT STREAM');
    if (event is FetchProductEvent) {
      yield ProductLoadingState();
      try {
        print('INSIDE PRODUCT FEATURED EVENT');
        print('INSIDE PRODUCT FEATURED EVENT');
        List<Product> products = await repository.getProducts();
        yield ProductsLoadedState(product: products);
      } catch (e) {
        yield ProductErrorState(message: e.toString());
      }
    }
    if (event is FetchCategoryProductEvent) {
      yield ProductLoadingState();
      try {
        List<Product> products =
            await repository.getCategoryProducts(event.catName);
        yield ProductsLoadedState(product: products);
      } catch (e) {
        yield ProductErrorState(message: e.toString());
      }
    }
    if (event is FetchProductByIDEvent) {
      yield ProductLoadingState();
      try {
        print('FETCH EVENT CALEED');
        Product product = await repository.getProductByID(event.pid);
        yield ProductLoadedState(product: product);
      } catch (e) {
        yield ProductErrorState(message: e.toString());
      }
    }
    if (event is PostProductQuestionEvent) {
      yield ProductLoadingState();
      try {
        bool posted = await repository.addQuestion(
            pid: event.pid, cid: event.cid, question: event.question);
        yield ProductPostQuestionState(posted: posted);
      } catch (e) {
        yield ProductErrorState(message: e.toString());
      }
    }
  }
}
