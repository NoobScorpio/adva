import 'dart:convert';
import 'package:adva/data/model/category.dart';
import 'package:adva/data/model/product.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<List<Product>> getCategoryProducts(String catName);
}

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<List<Category>> getCategories() async {
    var response = await http.get(baseURL + "/category");
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        var data = json.decode(response.body);

        List<Category> categories =
            CategoryResultModel.fromJson(data).categories;
        // print("CATEGORY Return");
        return categories;
      } catch (e) {
        print("CATEGORY $e");
        return [];
      }
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
    var response = await http.get(baseURL + "/product/index?category=$catName");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      // print(data['data']);
      print("PRICE TYPE ${data["data"][0]['price'].runtimeType} ");
      print("COST TYPE ${data["data"][0]['cost_price'].runtimeType} ");
      List<Product> products =
          ProductResultModel.fromJson(data['data']).products;

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
