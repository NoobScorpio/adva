import 'dart:convert';
import 'package:adva/data/model/product.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<List<Product>> getCategoryProducts(String catName);
}

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    var response = await http.get(baseURL + "/product/featured");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      print(data);
      List<Product> featured = ProductResultModel.fromJson(data).products;
      print(data);
      print(featured);
      return featured;
    } else if (response.statusCode == 400) {
      throw UnimplementedError('This data does not exist.');
    } else if (response.statusCode == 500) {
      throw UnimplementedError('Internal server error.');
    } else {
      throw UnimplementedError('Something went wrong');
    }
  }

  @override
  Future<List<Product>> getCategoryProducts(String catName) async {
    var response = await http.get(baseURL + "/product/index?categpry=$catName");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      print(data);
      List<Product> products = ProductResultModel.fromJson(data).products;
      print(data);
      print(products);
      return products;
    } else if (response.statusCode == 400) {
      throw UnimplementedError('This data does not exist.');
    } else if (response.statusCode == 500) {
      throw UnimplementedError('Internal server error.');
    } else {
      throw UnimplementedError('Something went wrong');
    }
  }
}
