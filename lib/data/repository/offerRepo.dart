import 'dart:convert';
import 'package:adva/data/model/offer.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class OfferRepository {
  Future<List<Offer>> getOffers();
}

class OfferRepositoryImpl implements OfferRepository {
  @override
  Future<List<Offer>> getOffers() async {
    var response = await http.get(baseURL + "/offer/index");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);

      List<Offer> offers = OfferResultModel.fromJson(data).offers;
      // print(data);
      // print(offers);
      return offers;
    } else if (response.statusCode == 400) {
      throw UnimplementedError('This data does not exist.');
    } else if (response.statusCode == 500) {
      throw UnimplementedError('Internal server error.');
    } else {
      throw UnimplementedError('Something went wrong');
    }
  }
}
