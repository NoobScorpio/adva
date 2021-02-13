import 'package:adva/bloc/category_bloc/categoryEvent.dart';
import 'package:adva/bloc/category_bloc/categoryState.dart';
import 'package:adva/bloc/seller_bloc/sellerEvent.dart';
import 'package:adva/bloc/seller_bloc/sellerState.dart';
import 'package:adva/data/model/seller.dart';
import 'package:adva/data/repository/sellerRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellerBloc extends Bloc<SellerEvent, SellerState> {
  final SellerRepository repository;

  SellerBloc({@required this.repository}) : super(null);

  @override
  // TODO: implement initialState
  SellerState get initialState => SellerInitialState();

  @override
  Stream<SellerState> mapEventToState(SellerEvent event) async* {
    if (event is FetchSellerEvent) {
      yield SellerLoadingState();
      try {
        List<Seller> sellings = await repository.getSellings();
        yield SellerLoadedState(seller: sellings);
      } catch (e) {
        yield SellerErrorState(message: e.toString());
      }
    }
  }
}
