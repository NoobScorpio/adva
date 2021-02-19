import 'dart:convert';

import 'package:adva/data/model/advaPoints.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;

abstract class PointsRepository {
  Future<ADVAPoints> getPoints(int cid);
}

class PointsRepositoryImpl extends PointsRepository {
  @override
  Future<ADVAPoints> getPoints(int cid) async {
    try {
      var response = await http.get(baseURL + "/customer/points/$cid");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("ADVA POINTS ${response.statusCode}");
        var data = json.decode(response.body);
        ADVAPoints aDVAPoints = ADVAPoints.fromJson(data);
        return aDVAPoints;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        print("${response.statusCode}" + ": " + "${response.body}");
        return null;
      } else if (response.statusCode == 500) {
        print("${response.statusCode}" + ": " + "${response.body}");
        return null;
      } else {
        print("${response.statusCode}" + ": " + "${response.body}");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
