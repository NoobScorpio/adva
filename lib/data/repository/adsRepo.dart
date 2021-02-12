import 'dart:async';
import 'dart:convert';

import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;
import 'package:adva/data/model/ads.dart';

abstract class AdsRepository {
  Future<List<Ads>> getAds();
}

class AdsRepositoryImpl implements AdsRepository {
  @override
  Future<List<Ads>> getAds() async {
    var response = await http.get(baseURL + "/ads");
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        List<Ads> ads = AdsResultModel.fromJson(data).ads;
        return ads;
      } catch (e) {
        print(e);
        return [];
      }
    } else {
      throw UnimplementedError();
    }
  }
}