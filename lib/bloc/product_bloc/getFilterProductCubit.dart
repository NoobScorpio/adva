import 'package:adva/bloc/product_bloc/productState.dart';
import 'package:adva/data/repository/productRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetFilterProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  GetFilterProductCubit({this.productRepository})
      : super(ProductInitialState());

  Future<void> getFilterProduct(int brand, int category) async {
    try {
      emit(ProductLoadingState());
      final product = await productRepository.getFilterProducts(
          brand: brand, category: category);
      emit(ProductFilterScreenState(products: product));
    } on Exception {
      emit(ProductErrorState(message: "Could not get product"));
    }
  }
}
