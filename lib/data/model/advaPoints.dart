import 'package:adva/data/model/conversion.dart';
import 'package:adva/data/model/points.dart';
import 'package:adva/data/model/promo.dart';

class ADVAPoints {
  List<Points> points;
  String total;
  Conversion conversion;
  Promo promo;

  ADVAPoints({this.points, this.total, this.conversion, this.promo});

  ADVAPoints.fromJson(Map<String, dynamic> json) {
    if (json['points'] != null) {
      points = new List<Points>();
      json['points'].forEach((v) {
        points.add(new Points.fromJson(v));
      });
    }
    total = json['total'];
    conversion = json['conversion'] != null
        ? new Conversion.fromJson(json['conversion'])
        : null;
    promo = json['promo'] != null ? new Promo.fromJson(json['promo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.points != null) {
      data['points'] = this.points.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    if (this.conversion != null) {
      data['conversion'] = this.conversion.toJson();
    }
    if (this.promo != null) {
      data['promo'] = this.promo.toJson();
    }
    return data;
  }
}
