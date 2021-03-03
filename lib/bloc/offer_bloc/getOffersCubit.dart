import 'package:adva/bloc/offer_bloc/offerState.dart';
import 'package:adva/data/repository/offerRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetOfferCubit extends Cubit<OfferState> {
  final OfferRepository offerRepository;

  GetOfferCubit({this.offerRepository}) : super(OfferInitialState());

  Future<void> getOffers() async {
    try {
      // emit(OfferLoadingState());
      final offers = await offerRepository.getOffers();
      final bundles = await offerRepository.getOffersBundle();
      emit(OfferLoadedState(offer: offers, bundle: bundles));
    } on Exception {
      emit(OfferErrorState());
    }
  }
}
