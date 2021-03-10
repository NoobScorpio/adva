import 'package:adva/data/model/payment.dart';
import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {}

class PaymentInitialState extends PaymentState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PaymentLoadingState extends PaymentState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PaymentLoadedState extends PaymentState {
  final List<Payment> payments;

  PaymentLoadedState({this.payments});

  @override
  // TODO: implement props
  List<Object> get props => [payments];
}

class PaymentErrorState extends PaymentState {
  final String message;

  PaymentErrorState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class PaymentDeleteState extends PaymentState {
  final List<Payment> payments;

  PaymentDeleteState(this.payments);
  @override
  // TODO: implement props
  List<Object> get props => [payments];
}

class PaymentAddState extends PaymentState {
  final List<Payment> payments;

  PaymentAddState(this.payments);
  @override
  // TODO: implement props
  List<Object> get props => [payments];
}
