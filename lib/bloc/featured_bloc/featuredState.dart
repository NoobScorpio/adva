import 'package:adva/data/model/featured.dart';
import 'package:equatable/equatable.dart';

//////////////////////    STATES     /////////////////////

abstract class FeaturedState extends Equatable {}

class FeaturedInitialState extends FeaturedState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FeaturedLoadingState extends FeaturedState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FeaturedLoadedState extends FeaturedState {
  final List<Featured> featured;

  FeaturedLoadedState({this.featured});

  @override
  // TODO: implement props
  List<Object> get props => [featured];
}

class FeaturedErrorState extends FeaturedState {
  final String message;

  FeaturedErrorState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
