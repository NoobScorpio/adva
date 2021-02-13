import 'dart:convert';
import 'package:adva/data/model/featured.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class FeaturedRepository {
  Future<List<Featured>> getFeatured();
}

class FeaturedRepositoryImpl implements FeaturedRepository {
  @override
  Future<List<Featured>> getFeatured() async {
    var response = await http.get(baseURL + "/product/featured");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      print(data);
      List<Featured> featured = FeaturedResultModel.fromJson(data).featured;
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
}
