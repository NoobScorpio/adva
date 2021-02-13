import 'package:adva/data/model/offer.dart';
import 'package:equatable/equatable.dart';

//////////////////////    STATES     /////////////////////

abstract class OfferState extends Equatable {}

class OfferInitialState extends OfferState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OfferLoadingState extends OfferState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OfferLoadedState extends OfferState {
  final List<Offer> offer;

  OfferLoadedState({this.offer});

  @override
  // TODO: implement props
  List<Object> get props => [offer];
}

class OfferErrorState extends OfferState {
  final String message;

  OfferErrorState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
