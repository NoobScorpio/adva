import 'dart:io';

import 'package:adva/bloc/product_bloc/productState.dart';
import 'package:adva/data/repository/productRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostReviewCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  PostReviewCubit({this.productRepository}) : super(ProductInitialState());

  Future<void> postReview(
      String message, int pid, int cid, int stars, List<File> files) async {
    try {
      emit(ProductLoadingState());
      final posted = await productRepository.addReview(
          message: message, pid: pid, cid: cid, stars: stars, pictures: files);
      emit(ProductPostReviewState(posted: posted));
    } on Exception {
      emit(ProductErrorState());
    }
  }

  Future<void> postReviewScreen(
      String message, int pid, int cid, int stars, List<File> files) async {
    try {
      emit(ProductLoadingState());
      final posted = await productRepository.addReview(
          message: message, pid: pid, cid: cid, stars: stars, pictures: files);
      emit(ProductPostReviewScreenState(posted: posted));
    } on Exception {
      emit(ProductErrorState());
    }
  }
}
