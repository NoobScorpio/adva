import 'package:adva/bloc/product_bloc/productState.dart';
import 'package:adva/data/repository/productRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetIDProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  GetIDProductCubit({this.productRepository}) : super(ProductInitialState());

  Future<void> getProduct(int pid) async {
    try {
      emit(ProductLoadingState());
      final product = await productRepository.getProductByID(pid);
      emit(ProductLoadedState(product: product));
    } on Exception {
      emit(ProductErrorState(message: "Could not get product"));
    }
  }
}
