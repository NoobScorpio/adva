import 'package:adva/data/model/bundle.dart';
import 'package:adva/data/model/offer.dart';
import 'package:adva/data/model/products.dart';
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
  final List<Bundle> bundle;
  OfferLoadedState({this.offer, this.bundle});

  @override
  // TODO: implement props
  List<Object> get props => [offer, bundle];
}

class OfferProductsLoadedState extends OfferState {
  final List<Bundle> products;

  OfferProductsLoadedState({this.products});

  @override
  // TODO: implement props
  List<Object> get props => [products];
}

class OfferErrorState extends OfferState {
  final String message;

  OfferErrorState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
