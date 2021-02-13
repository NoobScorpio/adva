import 'package:adva/data/model/seller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SellerState extends Equatable {}

class SellerInitialState extends SellerState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SellerLoadingState extends SellerState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SellerLoadedState extends SellerState {
  final List<Seller> seller;

  SellerLoadedState({@required this.seller});

  @override
  // TODO: implement props
  List<Object> get props => [seller];
}

class SellerErrorState extends SellerState {
  final String message;

  SellerErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
