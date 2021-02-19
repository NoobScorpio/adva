import 'package:adva/data/model/cartItem.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CartState extends Equatable {}

class CartInitialState extends CartState {
  final List<CartItem> carItems;

  CartInitialState(this.carItems);
  @override
  // TODO: implement props
  List<Object> get props => [carItems];
}

class CartLoadingState extends CartState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CartLoadedState extends CartState {
  final List<CartItem> cartItems;

  CartLoadedState({@required this.cartItems});

  @override
  // TODO: implement props
  List<Object> get props => [cartItems];
}

class CartErrorState extends CartState {
  final String message;

  CartErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class CartItemAddedState extends CartState {
  final List<CartItem> added;
  CartItemAddedState({@required this.added});

  @override
  // TODO: implement props
  List<Object> get props => [added];
}

class CartItemRemoveState extends CartState {
  final List<CartItem> removed;

  CartItemRemoveState({@required this.removed});

  @override
  // TODO: implement props
  List<Object> get props => [removed];
}

class GetCartItemState extends CartState {
  final List<CartItem> cartItems;

  GetCartItemState({@required this.cartItems});

  @override
  // TODO: implement props
  List<Object> get props => [cartItems];
}
