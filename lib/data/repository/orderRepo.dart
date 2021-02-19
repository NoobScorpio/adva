import 'dart:convert';

import 'package:adva/data/model/orderDetails.dart';
import 'package:adva/data/model/orderDetail.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class OrderRepository {
  Future<List<OrderDetails>> getOrders(int cid);
  Future<OrderDetail> getOrderDetail(int cid, int oid);
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
}
