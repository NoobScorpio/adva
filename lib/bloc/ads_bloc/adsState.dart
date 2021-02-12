import 'package:adva/data/model/ads.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
