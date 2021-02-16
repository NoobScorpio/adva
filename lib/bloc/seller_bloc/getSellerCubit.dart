import 'package:adva/bloc/seller_bloc/sellerState.dart';
import 'package:adva/data/repository/sellerRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetSellerCubit extends Cubit<SellerState> {
  final SellerRepository sellerRepository;

  GetSellerCubit({this.sellerRepository}) : super(SellerInitialState());

  Future<void> getSellers() async {
    try {
      emit(SellerLoadingState());
      final categories = await sellerRepository.getSellings();
      emit(SellerLoadedState(seller: categories));
    } on Exception {
      emit(SellerErrorState(message: "Could not get offers"));
    }
  }
}
