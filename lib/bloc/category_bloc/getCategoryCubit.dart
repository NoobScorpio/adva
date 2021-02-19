import 'package:adva/bloc/category_bloc/categoryState.dart';
import 'package:adva/data/repository/categoryRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetCategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository categoryRepository;

  GetCategoryCubit({this.categoryRepository}) : super(CategoryInitialState());

  Future<void> getCategories() async {
    try {
      // emit(CategoryLoadingState());
      final categories = await categoryRepository.getCategories();
      emit(CategoryLoadedState(category: categories));
    } on Exception {
      emit(CategoryErrorState());
    }
  }
}
