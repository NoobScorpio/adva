import 'dart:convert';
import 'package:adva/data/model/seller.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class SellerRepository {
  Future<List<Seller>> getSellings();
}

class SellerRepositoryImpl implements SellerRepository {
  @override
  Future<List<Seller>> getSellings() async {
    var response = await http.get(baseURL + "/topsellings");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      // print(data);
      List<Seller> sellings = SellerResultModel.fromJson(data).seller;
      // print(data);
      // print(sellings);
      return sellings;
    } else if (response.statusCode == 400) {
      throw UnimplementedError('This data does not exist.');
    } else if (response.statusCode == 500) {
      throw UnimplementedError('Internal server error.');
    } else {
      throw UnimplementedError('Something went wrong');
    }
  }
}