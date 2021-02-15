import 'dart:convert';
import 'package:adva/data/model/product.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<List<Product>> getCategoryProducts(String catName);
  Future<Product> getProductByID(int pid);
  Future<bool> addQuestion({String question, int pid, int cid});
}

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    var response = await http.get(baseURL + "/product/featured");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      // print(data);
      List<Product> featured = ProductResultModel.fromJson(data).products;
      // print(data);
      // print(featured);
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
      // print(data);
      // print(products);
      return products;
    } else if (response.statusCode == 400) {
      throw UnimplementedError('This data does not exist.');
    } else if (response.statusCode == 500) {
      throw UnimplementedError('Internal server error.');
    } else {
      throw UnimplementedError('Something went wrong');
    }
  }

  @override
  Future<Product> getProductByID(int pid) async {
    print('FETCH EVENT CALEED');
    var response = await http.get(baseURL + "/product/$pid");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      // print(data);
      Product product = Product.fromJson(data);
      // print(data);
      // print(product);
      return product;
    } else if (response.statusCode == 400) {
      throw UnimplementedError('This data does not exist.');
    } else if (response.statusCode == 500) {
      throw UnimplementedError('Internal server error.');
    } else {
      throw UnimplementedError('Something went wrong');
    }
  }

  @override
  Future<bool> addQuestion({String question, int pid, int cid}) async {
    var response = await http.post(baseURL +
        "/qa/create?product_id=$pid&customer_id=$cid&question=$question");
    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }
}
