import 'package:adva/bloc/offer_bloc/offerState.dart';
import 'package:adva/data/repository/offerRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetOfferCubit extends Cubit<OfferState> {
  final OfferRepository offerRepository;

  GetOfferCubit({this.offerRepository}) : super(OfferInitialState());

  Future<void> getOffers() async {
    try {
      // emit(OfferLoadingState());
      final categories = await offerRepository.getOffers();
      emit(OfferLoadedState(offer: categories));
    } on Exception {
      emit(OfferErrorState());
    }
  }
}
