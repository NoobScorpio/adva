import 'dart:convert';
import 'dart:io';
import 'package:adva/data/model/product.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductByID(int pid);
  Future<bool> addQuestion({String question, int pid, int cid});
  Future<dynamic> addReview(
      {String message, int pid, int cid, int stars, List<File> pictures});
  Future<List<Product>> getFilterProducts({int brand, int category});
  Future<List<Product>> getSortProducts({String sort});
}

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    var response = await http.get(baseURL + "/product/featured");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      // print(data);
      List<Product> featured =
          ProductResultModel.fromJson(data['data']).products;
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
  Future<Product> getProductByID(int pid) async {
    try {
      // print('FETCH EVENT CALEED');
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
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<bool> addQuestion({String question, int pid, int cid}) async {
    print("PID : $pid , CID: $cid , QUES: $question");
    var response = await http.post(baseURL +
        "/qa/create?product_id=$pid&customer_id=$cid&question=$question");
    if (response.statusCode == 200) {
      print("PostProductQuestionScreenEvent 200 RESPONSE");
      return true;
    } else {
      print("PostProductQuestionScreenEvent NO RESPONSE");
      return false;
    }
  }

  @override
  Future<dynamic> addReview(
      {String message,
      int pid,
      int cid,
      int stars,
      List<File> pictures}) async {
    try {
      var uri = Uri.parse(baseURL + "/review/create");
      var request = http.MultipartRequest(
        "POST",
        uri,
      );

      for (File file in pictures) {
        var stream = new http.ByteStream(http.ByteStream(file.openRead()));
        var length = await file.length();
        var multipartFileSign = new http.MultipartFile('photo', stream, length,
            filename: file.path.split("/").last);
        request.files.add(multipartFileSign);
      }
      request.fields['product_id'] = pid.toString();
      request.fields['customer_id'] = cid.toString();
      request.fields['review_message'] = message.toString();
      request.fields['stars'] = stars.toString();

      var response = await request.send();
      //  headers: {"Content-Type": "multipart/form-data"},
      //   body: {
      //     "images": [],
      //     "product_id": pid.toString(),
      //     "customer_id": cid.toString(),
      //     "stars": stars.toString(),
      //     "review_message": message.toString()
      //   },
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("PostProductReviewScreenEvent 200 RESPONSE");
        return true;
      } else if (response.statusCode == 400) {
        print('Bad Request');
        print(response.statusCode);
        print(response.stream);
        return 'You have to purchase this product.';
        // throw UnimplementedError('This data does not exist.');
      } else if (response.statusCode == 500) {
        print('Internal server error.');
        return false;
        // throw UnimplementedError('Internal server error.');
      } else {
        // print(response.body);
        print('Something went wrong');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List<Product>> getFilterProducts({int brand, int category}) async {
    var response = await http.get(baseURL +
        "/product/index?category=${category ?? ""}&brand=${brand ?? ""}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      // print(data);
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

  @override
  Future<List<Product>> getSortProducts({String sort}) async {
    var response = await http.get(baseURL + "/product/index?sort=$sort");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      // print(data);
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
