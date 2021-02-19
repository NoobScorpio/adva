import 'package:adva/data/model/ads.dart';
import 'package:adva/data/repository/adsRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class AdsBloc extends Bloc<AdsEvent, AdsState> {
  final AdsRepository repository;

  AdsBloc({@required this.repository}) : super(null);

  AdsState get initialState => AdsInitialState();

  @override
  Stream<AdsState> mapEventToState(AdsEvent event) async* {
    if (event is FetchAdsEvent) {
      yield AdsLoadingState();
      try {
        List<Ads> ads = await repository.getAds();
        yield AdsLoadedState(ads: ads);
      } catch (e) {
        yield AdsErrorState(message: e.toString());
      }
    }
  }
}
//////////////////////    EVENTS      /////////////////////////////

abstract class AdsEvent extends Equatable {}

class FetchAdsEvent extends AdsEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

//////////////////////    STATES     /////////////////////

abstract class AdsState extends Equatable {}

class AdsInitialState extends AdsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AdsLoadingState extends AdsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AdsLoadedState extends AdsState {
  final List<Ads> ads;

  AdsLoadedState({@required this.ads});

  @override
  // TODO: implement props
  List<Object> get props => [ads];
}

class AdsErrorState extends AdsState {
  final String message;

  AdsErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
