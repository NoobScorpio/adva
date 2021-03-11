import 'dart:convert';

import 'package:adva/data/model/brand.dart';
import 'package:adva/data/model/product.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class BrandRepository {
  Future<List<Brand>> getBrands();
  Future<List<Product>> getBrandProducts(String brand);
}

class BrandRepositoryImpl implements BrandRepository {
  @override
  Future<List<Brand>> getBrands() async {
    var response = await http.get(Uri.parse(baseURL + "/brand"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        var data = json.decode(response.body);
        // print("BRAND RETURN");
        // print("BRAND RETURN ${data}");
        // print("BRAND RETURN");
        List<Brand> brands = BrandResultModel.fromJson(data).brands;
        // print("BRAND RETURN LIST");
        return brands;
      } catch (e) {
        print("BRAND $e");
        return [];
      }
    } else if (response.statusCode == 400) {
      print("BRANDS 400");
      return null;
    } else if (response.statusCode == 500) {
      print("BRANDS 500");
      return null;
    } else {
      print("BRANDS UNKNOWN");
      return null;
    }
  }

  @override
  Future<List<Product>> getBrandProducts(String brand) async {
    var response =
        await http.get(Uri.parse(baseURL + "/product/index?brand=$brand"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      // print(data);
      List<Product> products =
          ProductResultModel.fromJson(data['data']).products;

      return products;
    } else if (response.statusCode == 400) {
      print("BRANDS PRODUCTS 400");
      return null;
    } else if (response.statusCode == 500) {
      print("BRANDS PRODUCTS 500");
      return null;
    } else {
      print("BRANDS PRODUCTS UNKNOWN");
      return null;
    }
  }
}
