import 'package:adva/bloc/ads_bloc/adsEvent.dart';
import 'package:adva/bloc/ads_bloc/adsState.dart';
import 'package:adva/data/model/ads.dart';
import 'package:adva/data/repository/adsRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdsBloc extends Bloc<AdsEvent, AdsState> {
  final AdsRepository repository;

  AdsBloc({@required this.repository}) : super(null);

  @override
  // TODO: implement initialState
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
