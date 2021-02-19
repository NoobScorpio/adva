import 'dart:async';
import 'dart:convert';
import 'package:adva/data/model/payment.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class PaymentRepository {
  Future<List<Payment>> getPayments(int cid);
  Future<List<Payment>> addPayment(Payment payment);
  Future<bool> deletePayment(Payment payment);
}

class PaymentRepositoryImpl implements PaymentRepository {
  @override
  Future<List<Payment>> addPayment(Payment payment) async {
    var response = await http.post(baseURL + "/paymentcard/create", body: {
      "customer_id": payment.customerId,
      "name_on_card": payment.nameOnCard,
      "card_number": payment.cardNumber,
      "expiry_date": payment.expiryDate,
      "security_code": payment.securityCode,
      "card_brand": payment.cardBrand
    });
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        List<Payment> payments = PaymentResultModel.fromJson(data).payments;
        return payments;
      } catch (e) {
        print(e);
        return null;
      }
    } else if (response.statusCode == 400) {
      print("PAYMENTS: ${response.statusCode}");
      return null;
    } else if (response.statusCode == 500) {
      print("PAYMENTS: ${response.statusCode}");
      return null;
    } else {
      print("PAYMENTS: ${response.statusCode}");
      return null;
    }
  }

  @override
  Future<bool> deletePayment(Payment payment) async {
    var response =
        await http.post(baseURL + "/paymentcard/delete/${payment.id}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 400) {
      print("PAYMENTS: ${response.statusCode}");
      return null;
    } else if (response.statusCode == 500) {
      print("PAYMENTS: ${response.statusCode}");
      return null;
    } else {
      print("PAYMENTS: ${response.statusCode}");
      return null;
    }
  }

  @override
  Future<List<Payment>> getPayments(int cid) async {
    var response = await http.get(baseURL + "/paymentcard/$cid");
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        List<Payment> payments = PaymentResultModel.fromJson(data).payments;
        return payments;
      } catch (e) {
        print(e);
        return null;
      }
    } else if (response.statusCode == 400) {
      print("PAYMENTS: ${response.statusCode}");
      return null;
    } else if (response.statusCode == 500) {
      print("PAYMENTS: ${response.statusCode}");
      return null;
    } else {
      print("PAYMENTS: ${response.statusCode}");
      return null;
    }
  }
}
