import 'dart:convert';

import 'package:adva/data/model/address.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class AddressRepository {
  Future<List<Address>> getAddresses(int cid);
  Future<List<Address>> addAddress({Address address});
  Future<List<Address>> deleteAddress({Address address});
  Future<bool> updateAddress({Address address});
}

class AddressRepositoryImpl implements AddressRepository {
  @override
  Future<List<Address>> getAddresses(int cid) async {
    // print("GET ADDRESS ID: $cid");
    var response = await http.get(baseURL + "/address/$cid");
    // print("GET ADDRESS RESPONSE: ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        var data = json.decode(response.body);
        List<Address> addresses = AddressResultModel.fromJson(data).addresses;
        // print("GET ADDRESS REQUEST RETURN");
        return addresses;
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
  Future<List<Address>> addAddress({Address address}) async {
    var response = await http.post(
        baseURL + "/customer/address/create/${address.customerId}",
        body: {
          "address": address.address,
          "country": address.country,
          "city": address.city,
          "postal_code": address.postalCode,
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        var data = json.decode(response.body);
        List<Address> addresses = AddressResultModel.fromJson(data).addresses;
        return addresses;
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
  Future<List<Address>> deleteAddress({Address address}) async {
    var response = await http
        .post(baseURL + "/customer/address/delete/${address.id}", body: {
      "customer_id": address.customerId.toString(),
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        var data = json.decode(response.body);
        List<Address> addresses = AddressResultModel.fromJson(data).addresses;
        return addresses;
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
  Future<bool> updateAddress({Address address}) async {
    try {
      print("updateAddress ID ${address.id}");
      print("updateAddress CID ${address.customerId}");
      print("updateAddress ADDRESS ${address.address}");
      print("updateAddress COUNTRY ${address.country}");
      print("updateAddress CITY ${address.city}");
      print("updateAddress POSTAL-CODE ${address.postalCode}");
      var response = await http.post(
          baseURL + "/customer/address/update/${address.id.toString()}",
          body: {
            "customer_id": address.customerId.toString(),
            "address": address.address,
            "country": address.country,
            "city": address.city,
            "postal_code": address.postalCode,
          });
      print("updateAddress: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 400) {
        return false;
      } else if (response.statusCode == 500) {
        return false;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
