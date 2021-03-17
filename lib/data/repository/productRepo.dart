import 'dart:convert';
import 'dart:io';
import 'package:adva/data/model/product.dart';
import 'package:adva/data/model/searchProduct.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductByID(int pid);
  Future<bool> addQuestion({String question, int pid, int cid});
  Future<String> addReview(
      {String message, int pid, int cid, int stars, List<File> pictures});
  Future<List<Product>> getFilterProducts({int brand, int category});
  Future<List<Product>> getSortProducts({String sort});
  Future<List<SearchProduct>> getAllProducts({search});
}

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    var response = await http.get(Uri.parse(baseURL + "/product/featured"));
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
  Future<List<SearchProduct>> getAllProducts({search}) async {
    var response =
        await http.get(Uri.parse(baseURL + "/search?search=$search"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      // print(data);
      List<SearchProduct> search =
          SearchProductResultModel.fromJson(data).searchProduct;
      print("@SEARCH DATA : $data");
      print("@SEARCH LENGTH ${search.length}");
      return search;
    } else if (response.statusCode == 400) {
      return null;
    } else if (response.statusCode == 500) {
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<Product> getProductByID(int pid) async {
    try {
      // print('FETCH EVENT CALEED');
      var response = await http.get(Uri.parse(baseURL + "/product/$pid"));
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
    var response = await http.post(Uri.parse(baseURL +
        "/qa/create?product_id=$pid&customer_id=$cid&question=$question"));
    if (response.statusCode == 200) {
      print("PostProductQuestionScreenEvent 200 RESPONSE");
      return true;
    } else {
      print("PostProductQuestionScreenEvent NO RESPONSE");
      return false;
    }
  }

  @override
  Future<String> addReview(
      {String message,
      int pid,
      int cid,
      int stars,
      List<File> pictures}) async {
    try {
      List<dynamic> images = [];

      for (File file in pictures) {
        List<int> imageBytes = file.readAsBytesSync();
        String ext = file.path.split('/').last.split('.').last;

        String baseImage = base64Encode(imageBytes);

        images.add({"image": baseImage, "filetype": ext});
      }

      var response = await http.post(
        Uri.parse(baseURL + "/review/basedecode/create"),
        body: {
          "images": json.encode(images),
          "product_id": pid.toString(),
          "customer_id": cid.toString(),
          "stars": stars.toString(),
          "review_message": message.toString()
        },
      );
      //  headers: {"Content-Type": "multipart/form-data"},

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("PostProductReviewScreenEvent 200 RESPONSE");
        return "Success";
      } else if (response.statusCode == 400) {
        print('Bad Request ${response.body}');
        print(response.statusCode);

        return 'You have to purchase this product.';
        // throw UnimplementedError('This data does not exist.');
      } else if (response.statusCode == 500) {
        print('Internal server error.');
        return null;
        // throw UnimplementedError('Internal server error.');
      } else {
        // print(response.body);
        print('Something went wrong');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<Product>> getFilterProducts({int brand, int category}) async {
    var response = await http.get(Uri.parse(baseURL +
        "/product/index?category=${category ?? ""}&brand=${brand ?? ""}"));
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
    var response =
        await http.get(Uri.parse(baseURL + "/product/index?sort=$sort"));
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
