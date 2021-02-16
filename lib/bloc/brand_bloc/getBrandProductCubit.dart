import 'package:adva/bloc/brand_bloc/brandState.dart';
import 'package:adva/data/repository/brandRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetBrandProductsCubit extends Cubit<BrandState> {
  final BrandRepository brandRepository;

  GetBrandProductsCubit({this.brandRepository}) : super(BrandInitialState());

  Future<void> getBrandProducts(String brand) async {
    try {
      emit(BrandLoadingState());
      final categories = await brandRepository.getBrandProducts(brand);
      emit(BrandProductsLoadedState(products: categories));
    } on Exception {
      emit(BrandErrorState());
    }
  }
}
