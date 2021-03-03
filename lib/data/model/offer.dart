import 'package:adva/data/model/products.dart';

class Offer {
  int id;
  String name;
  int discount;
  String fromDate;
  String toDate;
  String image;
  String offerOn;
  String createdAt;
  String updatedAt;
  List<Products> products;

  Offer(
      {this.id,
      this.name,
      this.discount,
      this.fromDate,
      this.toDate,
      this.image,
      this.offerOn,
      this.createdAt,
      this.updatedAt,
      this.products});

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    discount = json['discount'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    image = json['image'];
    offerOn = json['offer_on'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['discount'] = this.discount;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['image'] = this.image;
    data['offer_on'] = this.offerOn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferResultModel {
  List<Offer> offers;

  OfferResultModel({this.offers});

  OfferResultModel.fromJson(List<dynamic> json) {
    if (json != null) {
      offers = List<Offer>();
      json.forEach((v) {
        offers.add(new Offer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.offers != null) {
      data['offers'] = this.offers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
