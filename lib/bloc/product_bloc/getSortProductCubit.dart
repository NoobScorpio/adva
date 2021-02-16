import 'package:adva/bloc/product_bloc/productState.dart';
import 'package:adva/data/repository/productRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetSortProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  GetSortProductCubit({this.productRepository}) : super(ProductInitialState());

  Future<void> getSortProduct(String sort) async {
    try {
      emit(ProductLoadingState());
      final product = await productRepository.getSortProducts(sort: sort);
      emit(ProductSortScreenState(products: product));
    } on Exception {
      emit(ProductErrorState(message: "Could not get sort product"));
    }
  }
}
