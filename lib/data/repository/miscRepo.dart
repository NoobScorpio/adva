import 'dart:convert';

import 'package:adva/data/model/codRate.dart';
import 'package:adva/data/model/discountRate.dart';
import 'package:adva/data/model/promo.dart';
import 'package:adva/data/model/shipRate.dart';
import 'package:adva/data/model/taxRate.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class MiscRepository {
  Future<ShipRate> getShipRate();
  Future<dynamic> getFreeShipRate();
  Future<CODRate> getCODRate();
  Future<TaxRate> getTaxRate();
  Future<Promo> getPromo({String promo});
  Future<DiscountRate> getDiscount({String discount});
  Future<String> getAnswer({question});
}

class MiscRepositoryImpl extends MiscRepository {
  SharedPreferences sp;
  @override
  Future<CODRate> getCODRate() async {
    sp = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(baseURL + "/setting/cod/get"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        var data = json.decode(response.body);
        CODRate cod = CODRate.fromJson(data);
        await sp.setString('cod', json.encode(cod.toJson()));
        return cod;
      } catch (e) {
        print(e);
        return null;
      }
    } else if (response.statusCode == 400) {
      return null;
    } else if (response.statusCode == 500) {
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<DiscountRate> getDiscount({String discount}) async {
    print("@MISC DISCOUNT $discount");
    sp = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(baseURL + "/discount/check"),
        body: {"discount_code": discount});
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        var data = json.decode(response.body);
        DiscountRate discount = DiscountRate.fromJson(data);
        await sp.setString('discount', json.encode(discount.toJson()));
        return discount;
      } catch (e) {
        print(e);
        return null;
      }
    } else if (response.statusCode == 400) {
      return null;
    } else if (response.statusCode == 500) {
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<Promo> getPromo({String promo}) async {
    sp = await SharedPreferences.getInstance();
    var response = await http
        .post(Uri.parse(baseURL + "/promo/check"), body: {"promo_code": promo});
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        var data = json.decode(response.body);
        Promo promoData = Promo.fromJson(data);
        await sp.setString('promo', json.encode(promoData.toJson()));
        return promoData;
      } catch (e) {
        print(e);
        return null;
      }
    } else if (response.statusCode == 400) {
      return null;
    } else if (response.statusCode == 500) {
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<ShipRate> getShipRate() async {
    try {
      sp = await SharedPreferences.getInstance();
      var response =
          await http.get(Uri.parse(baseURL + "/setting/shippingrate/get"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          var data = json.decode(response.body);
          print("SHIP $data");
          ShipRate ship = ShipRate.fromJson(data);
          print("SHIP ${ship.toJson()}");
          await sp.setString('shipRate', json.encode(ship.toJson()));
          return ship;
        } catch (e) {
          print(e);
          return null;
        }
      } else if (response.statusCode == 400) {
        return null;
      } else if (response.statusCode == 500) {
        return null;
      } else {
        return null;
      }
    } catch (e) {
      print("SHIP $e");
      return null;
    }
  }

  @override
  Future<TaxRate> getTaxRate() async {
    sp = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(baseURL + "/setting/tax/get"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        var data = json.decode(response.body);
        TaxRate tax = TaxRate.fromJson(data);
        await sp.setString('taxRate', json.encode(tax.toJson()));
        return tax;
      } catch (e) {
        print(e);
        return null;
      }
    } else if (response.statusCode == 400) {
      return null;
    } else if (response.statusCode == 500) {
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<String> getAnswer({question}) async {
    try {
      final newURI = Uri.parse(baseURL + "/chatbot")
          .replace(queryParameters: {"question": question});
      var response = await http.get(newURI);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("@CHATBOT ${response.body}");
        return response.body;
      } else if (response.statusCode == 400) {
        return null;
      } else if (response.statusCode == 500) {
        return null;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<dynamic> getFreeShipRate() async {
    sp = await SharedPreferences.getInstance();
    var response =
        await http.get(Uri.parse(baseURL + "/setting/shippingrate/get"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        var data = json.decode(response.body);
        await sp.setString('freeShip', data['free_shipping'].toString());
        return data['free_shipping'];
      } catch (e) {
        print(e);
        return null;
      }
    } else if (response.statusCode == 400) {
      return null;
    } else if (response.statusCode == 500) {
      return null;
    } else {
      return null;
    }
  }
}
