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
    var response = await http.get(Uri.parse(baseURL + "/category"));
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
  Future<List<Product>> getCategoryProducts(String catName) async {
    var response = await http.get(Uri.parse(baseURL + "/product/index?category=$catName"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      // print(data['data']);
      // print("PRICE TYPE ${data["data"][0]['price'].runtimeType} ");
      // print("COST TYPE ${data["data"][0]['cost_price'].runtimeType} ");
      List<Product> products =
          ProductResultModel.fromJson(data['data']).products;

      return products;
    } else if (response.statusCode == 400) {
      print("CATEGORY 400");
      return null;
    } else if (response.statusCode == 500) {
      print("CATEGORY 500");
      return null;
    } else {
      print("CATEGORY UNKNOWN");
      return null;
    }
  }
}
