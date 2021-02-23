import 'package:adva/bloc/product_bloc/productState.dart';
import 'package:adva/data/repository/productRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostQuestionCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  PostQuestionCubit({this.productRepository}) : super(ProductInitialState());

  Future<bool> postQuestion(int pid, String qas, int cid) async {
    try {
      emit(ProductLoadingState());
      final posted = await productRepository.addQuestion(
          pid: pid, question: qas, cid: cid);
      emit(ProductPostQuestionState(posted: posted));
      return posted;
    } on Exception {
      emit(ProductErrorState());
      return false;
    }
  }

  Future<void> postQuestionScreen(int pid, String qas, int cid) async {
    try {
      emit(ProductLoadingState());
      final posted = await productRepository.addQuestion(
          pid: pid, question: qas, cid: cid);
      emit(ProductPostQuestionScreenState(posted: posted));
    } on Exception {
      emit(ProductErrorState());
    }
  }
}
