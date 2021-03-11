import 'dart:async';
import 'dart:convert';
import 'package:adva/data/model/wishlist.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class WishRepository {
  Future<int> addWishListItem(int cid, int pid);
  Future<bool> removeWishListItem(int cid, int wid);
  Future<List<WishList>> getWishListItems(int cid);
}

class WishRepositoryImpl implements WishRepository {
  @override
  Future<int> addWishListItem(int cid, int pid) async {
    print("ADD WISH: $cid $pid");
    try {
      var response = await http.post(Uri.parse(baseURL + "/wishlist/create"),
          body: {"customer_id": cid.toString(), "product_id": pid.toString()});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return 200;
      } else if (response.statusCode == 400) {
        print('Response 400:${response.body}');
        return 400;
      } else if (response.statusCode == 500) {
        print('Response 500:${response.body}');
        return 500;
      } else {
        print('Something went wrong');
        return 500;
      }
    } catch (e) {
      print("ADD WISH ITEM EXCEPTION $e");
      return 500;
    }
  }

  @override
  Future<List<WishList>> getWishListItems(int cid) async {
    try {
      var response = await http.get(
        Uri.parse(baseURL + "/wishlist/$cid"),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        List<WishList> wishLists = WishListResultModel.fromJson(data).wishLists;
        return wishLists;
      } else if (response.statusCode == 400) {
        print('Response 400: This data does not exist.');
        return null;
      } else if (response.statusCode == 500) {
        print('Response 500:Internal server error.');
        return null;
      } else {
        print('Something went wrong');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<bool> removeWishListItem(int cid, int wid) async {
    try {
      print("REMOVE WISH : $cid $wid");
      var response = await http.post(Uri.parse(baseURL + "/wishlist/delete"),
          body: {"customer_id": cid.toString(), "wishlist_id": wid.toString()});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 400) {
        print('This data does not exist.');
        return false;
      } else if (response.statusCode == 500) {
        print('Internal server error.');
        return false;
      } else {
        print('Something went wrong');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
