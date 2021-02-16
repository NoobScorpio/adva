import 'package:adva/bloc/brand_bloc/brandState.dart';
import 'package:adva/data/repository/brandRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetBrandsCubit extends Cubit<BrandState> {
  final BrandRepository brandRepository;

  GetBrandsCubit({this.brandRepository}) : super(BrandInitialState());

  Future<void> getBrands() async {
    try {
      emit(BrandLoadingState());
      final brands = await brandRepository.getBrands();
      emit(BrandLoadedState(brands: brands));
    } on Exception {
      emit(BrandErrorState(message: "Could not get featured brands"));
    }
  }
}
