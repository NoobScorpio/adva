import 'package:adva/bloc/product_bloc/productState.dart';
import 'package:adva/data/model/product.dart';
import 'package:adva/data/repository/productRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetIDProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  GetIDProductCubit({this.productRepository}) : super(ProductInitialState());

  Future<Product> getProduct(int pid) async {
    try {
      emit(ProductLoadingState());
      final product = await productRepository.getProductByID(pid);
      print("PRODUCT RETURNED");
      emit(ProductLoadedState(product: product));
      return product;
    } on Exception {
      emit(ProductErrorState(message: "Could not get product"));
      return null;
    }
  }
}
