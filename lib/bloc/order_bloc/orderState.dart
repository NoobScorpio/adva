import 'package:adva/data/model/orderDetail.dart';
import 'package:adva/data/model/orderDetails.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class OrderState extends Equatable {}

class OrderInitialState extends OrderState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OrderLoadingState extends OrderState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OrderLoadedState extends OrderState {
  final List<OrderDetails> orderDetails;

  OrderLoadedState({@required this.orderDetails});

  @override
  // TODO: implement props
  List<Object> get props => [orderDetails];
}

class OrderReturnsState extends OrderState {
  final List<OrderDetails> orderDetails;

  OrderReturnsState({@required this.orderDetails});

  @override
  // TODO: implement props
  List<Object> get props => [orderDetails];
}

class OrderDetailsLoadedState extends OrderState {
  final List<OrderDetails> orderDetails;
  final OrderDetail orderDetail;

  OrderDetailsLoadedState({this.orderDetail, this.orderDetails});

  @override
  // TODO: implement props
  List<Object> get props => [orderDetails, orderDetail];
}

class OrderErrorState extends OrderState {
  final String message;

  OrderErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
