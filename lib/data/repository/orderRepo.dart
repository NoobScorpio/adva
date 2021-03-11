import 'dart:convert';

import 'package:adva/data/model/order.dart';
import 'package:adva/data/model/orderDetails.dart';
import 'package:adva/data/model/orderDetail.dart';
import 'package:adva/data/model/return.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class OrderRepository {
  Future<List<OrderDetails>> getOrders(int cid);
  Future<OrderDetail> getOrderDetail(int cid, int oid);
  Future<List<Return>> getReturns(int cid);
  Future<int> createOrder({Order order});
  Future<bool> confirmOrder({Order order});
  Future<bool> returnOrder();
}

class OrderRepositoryImpl extends OrderRepository {
  @override
  Future<List<OrderDetails>> getOrders(int cid) async {
    try {
      var response = await http.get(baseURL + "/order/$cid");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("OrderDetails  ${response.statusCode}");
        var data = json.decode(response.body);
        List<OrderDetails> orderDetaisl =
            OrderDetailsResultModel.fromJson(data).orderDetails;
        return orderDetaisl;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        print("${response.statusCode}" + ": " + "${response.body}");
        return null;
      } else if (response.statusCode == 500) {
        print("${response.statusCode}" + ": " + "${response.body}");
        return null;
      } else {
        print("${response.statusCode}" + ": " + "${response.body}");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<OrderDetail> getOrderDetail(int cid, int oid) async {
    try {
      var response = await http.get(baseURL + "/order/details/$cid/$oid");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("OrderDetail  ${response.statusCode}");
        var data = json.decode(response.body);
        print(response.body);
        OrderDetail orderDetail = OrderDetail.fromJson(data);
        return orderDetail;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        print("${response.statusCode}" + ": " + "${response.body}");
        return null;
      } else if (response.statusCode == 500) {
        print("${response.statusCode}" + ": " + "${response.body}");
        return null;
      } else {
        print("${response.statusCode}" + ": " + "${response.body}");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<Return>> getReturns(int cid) async {
    try {
      var response = await http.get(baseURL + "/returned/orders/$cid");
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print("OrderDetails  ${response.statusCode}");
        var data = json.decode(response.body);
        List<Return> returns = ReturnResultModel.fromJson(data).returns;
        return returns;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        print("${response.statusCode}" + ": " + "${response.body}");
        return null;
      } else if (response.statusCode == 500) {
        print("${response.statusCode}" + ": " + "${response.body}");
        return null;
      } else {
        print("${response.statusCode}" + ": " + "${response.body}");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<int> createOrder({Order order}) async {
    print('@ORDER ID ${order.id}');
    print("@ORDER PROMO ${order.promoCode}");
    print("@ORDER DISCOUNT ${order.discountCode}");
    print("@ORDER POINTS ${order.pointsDiscount}");
    try {
      var response = await http.post(baseURL + "/order/create", body: {
        "customer_id": order.customerId.toString(),
        "total": order.total.toString(),
        "phone": order.phone.toString(),
        "email": order.email.toString(),
        "address_id": order.addressId.toString(),
        "payment_type": order.paymentType.toString(),
        "promo_code": order.promoCode,
        "discount_code": order.discountCode,
        "points_discount": order.pointsDiscount.toString(),
        "products": json.encode(order.products),
        "is_mobile": true.toString(),
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        print("@ORDER CREATE $data");
        print("@ORDER CREATE ${data['points']}");
        return data['points'];
      } else if (response.statusCode == 400) {
        print('Response 400:${response.body}');
        return null;
      } else if (response.statusCode == 500) {
        print('Response 500:${response.body}');
        return null;
      } else {
        print('Something went wrong');
        return null;
      }
    } catch (e) {
      print("ORDER EXCEPTION $e");
      return null;
    }
  }

  @override
  Future<bool> confirmOrder({Order order}) async {
    print('@ORDER ID ${order.id}');
    print("@ORDER PROMO ${order.promoCode}");
    print("@ORDER DISCOUNT ${order.discountCode}");
    print("@ORDER POINTS ${order.pointsDiscount}");
    try {
      var response =
          await http.post(baseURL + "/customer/payment/confirm", body: {
        "id": order.id,
        "customer_id": order.customerId.toString(),
        "total": order.total.toString(),
        "phone": order.phone.toString(),
        "email": order.email.toString(),
        "address_id": order.addressId.toString(),
        "payment_type": order.paymentType.toString(),
        "promo_code": order.promoCode,
        "discount_code": order.discountCode,
        "points_discount": order.pointsDiscount.toString(),
        "products": json.encode(order.products),
        "is_mobile": true.toString(),
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        RegExp exp = new RegExp(r"/^(000\.000\.|000\.100\.1|000\.[36])/");
        var data = json.decode(response.body);
        String code = data['result']['code'];
        print("@CODE $code");

        bool match = exp.hasMatch(code);
        // print("@ORDER CREATE $data");
        // print("@ORDER CREATE ${data['result']['code']}");
        if (match) {
          return true;
        }
        return null;
      } else if (response.statusCode == 400) {
        print('Response 400:${response.body}');
        return null;
      } else if (response.statusCode == 500) {
        print('Response 500:${response.body}');
        return null;
      } else {
        print('Something went wrong');
        return null;
      }
    } catch (e) {
      print("ORDER EXCEPTION $e");
      return null;
    }
  }

  @override
  Future<bool> returnOrder() {
    // TODO: implement returnOrder
    throw UnimplementedError();
  }
}
