import 'package:adva/bloc/payment_bloc/paymentState.dart';
import 'package:adva/data/model/payment.dart';
import 'package:adva/data/repository/paymentRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository paymentRepository;

  PaymentCubit({this.paymentRepository}) : super(PaymentInitialState());

  Future<void> getPayments(int cid) async {
    try {
      emit(PaymentLoadingState());
      final payments = await paymentRepository.getPayments(cid);
      emit(PaymentLoadedState(payments: payments));
    } on Exception {
      emit(PaymentErrorState(message: "Could not get payments"));
    }
  }

  Future<bool> addPayment(Payment payment) async {
    try {
      emit(PaymentLoadingState());
      final payments = await paymentRepository.addPayment(payment);
      emit(PaymentAddState(payments));
      return payments != null ? true : false;
    } on Exception {
      emit(PaymentErrorState(message: "Could not add address"));
      await getPayments(payment.customerId);
      return false;
    }
  }

  Future<bool> deletePayment(Payment payment) async {
    try {
      emit(PaymentLoadingState());
      final deleted = await paymentRepository.deletePayment(payment);
      if (deleted) {
        await getPayments(payment.customerId);
        return true;
      } else {
        await getPayments(payment.customerId);
        return false;
      }
    } on Exception {
      emit(PaymentErrorState(message: "Could not delete address"));
      await getPayments(payment.customerId);

      return false;
    }
  }
}
