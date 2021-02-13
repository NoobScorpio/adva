import 'dart:convert';
import 'package:adva/data/model/category.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
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

        return categories;
      } catch (e) {
        // print(e);
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
}
