import 'package:adva/bloc/offer_bloc/offerState.dart';
import 'package:adva/data/repository/offerRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetOfferProductsCubit extends Cubit<OfferState> {
  final OfferRepository offerRepository;

  GetOfferProductsCubit({this.offerRepository}) : super(OfferInitialState());

  Future<void> getOfferProducts() async {
    try {
      emit(OfferLoadingState());
      final bundles = await offerRepository.getOffersBundle();
      emit(OfferProductsLoadedState(products: bundles));
    } on Exception {
      emit(OfferErrorState());
    }
  }
}
