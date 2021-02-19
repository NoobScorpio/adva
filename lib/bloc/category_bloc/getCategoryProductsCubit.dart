import 'package:adva/bloc/category_bloc/categoryState.dart';
import 'package:adva/data/repository/categoryRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetCategoryProductsCubit extends Cubit<CategoryState> {
  final CategoryRepository categoryRepository;

  GetCategoryProductsCubit({this.categoryRepository})
      : super(CategoryInitialState());

  Future<void> getCategoryProducts(String catName) async {
    try {
      // emit(CategoryLoadingState());
      final categories = await categoryRepository.getCategoryProducts(catName);
      emit(CategoryProductsLoadedState(products: categories));
    } on Exception {
      emit(CategoryErrorState());
    }
  }
}
