import 'package:adva/data/model/return.dart';
import 'package:adva/data/repository/orderRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ReturnCubit extends Cubit<ReturnState> {
  final OrderRepository orderRepository;

  ReturnCubit({this.orderRepository}) : super(ReturnInitialState());

  Future<void> getReturns(int cid) async {
    try {
      emit(ReturnLoadingState());
      final returns = await orderRepository.getReturns(cid);
      emit(ReturnLoadedState(returns: returns));
    } on Exception {
      emit(ReturnErrorState(message: "Could not get orders"));
    }
  }
}

abstract class ReturnState extends Equatable {}

class ReturnInitialState extends ReturnState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ReturnLoadingState extends ReturnState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ReturnLoadedState extends ReturnState {
  final List<Return> returns;

  ReturnLoadedState({@required this.returns});

  @override
  // TODO: implement props
  List<Object> get props => [returns];
}

class ReturnErrorState extends ReturnState {
  final String message;

  ReturnErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
