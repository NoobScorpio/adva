import 'package:adva/bloc/order_bloc/orderState.dart';
import 'package:adva/data/repository/orderRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository orderRepository;

  OrderCubit({this.orderRepository}) : super(OrderInitialState());

  Future<void> getOrders(int cid) async {
    try {
      emit(OrderLoadingState());
      final orderDetails = await orderRepository.getOrders(cid);
      emit(OrderLoadedState(orderDetails: orderDetails));
    } on Exception {
      emit(OrderErrorState(message: "Could not get orders"));
    }
  }

  Future<void> getOrderDetails(int cid, int oid) async {
    try {
      emit(OrderLoadingState());
      final orderDetails = await orderRepository.getOrderDetail(cid, oid);
      final orders = await orderRepository.getOrders(cid);
      emit(OrderDetailsLoadedState(
          orderDetail: orderDetails, orderDetails: orders));
    } on Exception {
      emit(OrderErrorState(message: "Could not get orders"));
    }
  }
}
