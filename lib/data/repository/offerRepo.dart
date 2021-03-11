import 'dart:convert';
import 'package:adva/data/model/bundle.dart';
import 'package:adva/data/model/offer.dart';
import 'package:adva/data/model/product.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class OfferRepository {
  Future<List<Offer>> getOffers();
  Future<List<Bundle>> getOffersBundle();
  Future<List<Product>> getOfferProducts({oid});
}

class OfferRepositoryImpl implements OfferRepository {
  @override
  Future<List<Offer>> getOffers() async {
    var response = await http.get(Uri.parse(baseURL + "/offer/index"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      print('OFFER DATA: $data AND ${data.runtimeType}');
      if (data == [] || data == null || data.length == 0) {
        print('OFFERS ARE NULL');
        return null;
      }
      List<Offer> offers = OfferResultModel.fromJson(data['offer']).offers;
      return offers;
    } else if (response.statusCode == 400) {
      return null;
    } else if (response.statusCode == 500) {
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<List<Bundle>> getOffersBundle() async {
    var response = await http.get(Uri.parse(baseURL + "/offer/index"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);

      if (data == [] || data == null || data.length == 0) {
        print('BUNDLES ARE NULL');
        return null;
      }
      List<Bundle> bundle = BundleResultModel.fromJson(data).bundle;
      return bundle;
    } else if (response.statusCode == 400) {
      return null;
    } else if (response.statusCode == 500) {
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<List<Product>> getOfferProducts({oid}) async {
    var response = await http.get(Uri.parse(baseURL + "/product/index?offer=$oid"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);

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
