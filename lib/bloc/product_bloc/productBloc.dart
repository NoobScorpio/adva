import 'package:adva/bloc/product_bloc/productEvent.dart';
import 'package:adva/bloc/product_bloc/productState.dart';
import 'package:adva/data/model/product.dart';
import 'package:adva/data/repository/productRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({@required this.repository}) : super(null);

  ProductState get initialState => ProductInitialState();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    print('INSIDE PRODUCT STREAM');
    if (event is FetchProductEvent) {
      yield ProductLoadingState();
      try {
        print('FetchProductEvent Called');
        List<Product> products = await repository.getProducts();
        yield ProductsLoadedState(product: products);
      } catch (e) {
        print('FetchProductEvent ERROR');
        yield ProductErrorState(message: e.toString());
      }
    }

    if (event is FetchProductByIDEvent) {
      yield ProductLoadingState();
      try {
        print('FetchProductByIDEvent Called');
        Product product = await repository.getProductByID(event.pid);
        yield ProductLoadedState(product: product);
      } catch (e) {
        print('FetchProductByIDEvent Error');
        yield ProductErrorState(message: e.toString());
      }
    }
    if (event is PostProductQuestionEvent) {
      yield ProductLoadingState();
      try {
        print('PostProductQuestionEvent Called');
        bool posted = await repository.addQuestion(
            pid: event.pid, cid: event.cid, question: event.question);
        yield ProductPostQuestionState(posted: posted);
      } catch (e) {
        print('PostProductQuestionEvent Error');
        yield ProductErrorState(message: e.toString());
      }
    }

    if (event is PostProductQuestionScreenEvent) {
      yield ProductLoadingState();
      try {
        print('PostProductQuestionScreenEvent Called');
        bool posted = await repository.addQuestion(
            pid: event.pid, cid: event.cid, question: event.question);
        yield ProductPostQuestionScreenState(posted: posted);
      } catch (e) {
        print('PostProductQuestionScreenEvent Error');
        yield ProductErrorState(message: e.toString());
      }
    }
    if (event is PostProductReviewEvent) {
      yield ProductLoadingState();
      try {
        print('PostProductReviewEvent Called');
        dynamic posted = await repository.addReview(
            pid: event.pid,
            cid: event.cid,
            message: event.message,
            stars: event.stars,
            pictures: event.pictures);
        yield ProductPostReviewState(posted: posted);
      } catch (e) {
        print('PostProductReviewEvent Error');
        yield ProductErrorState(message: e.toString());
      }
    }
    if (event is PostProductReviewScreenEvent) {
      yield ProductLoadingState();
      try {
        print('PostProductReviewScreenEvent Called');
        dynamic posted = await repository.addReview(
            pid: event.pid,
            cid: event.cid,
            message: event.message,
            stars: event.stars,
            pictures: event.pictures);
        yield ProductPostReviewScreenState(posted: posted);
      } catch (e) {
        print('PostProductReviewScreenEvent Error');
        yield ProductErrorState(message: e.toString());
      }
    }
  }
}
