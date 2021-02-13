import 'package:adva/bloc/offer_bloc/offerEvent.dart';
import 'package:adva/bloc/offer_bloc/offerState.dart';
import 'package:adva/data/model/offer.dart';
import 'package:adva/data/repository/offerRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  final OfferRepository repository;

  OfferBloc({@required this.repository}) : super(null);

  @override
  // TODO: implement initialState
  OfferState get initialState => OfferInitialState();

  @override
  Stream<OfferState> mapEventToState(OfferEvent event) async* {
    if (event is FetchOfferEvent) {
      yield OfferLoadingState();
      try {
        List<Offer> offers = await repository.getOffers();
        yield OfferLoadedState(offer: offers);
      } catch (e) {
        yield OfferErrorState(message: e.toString());
      }
    }
  }
}
