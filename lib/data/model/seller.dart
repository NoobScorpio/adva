import 'package:adva/data/model/productImage.dart';

class Seller {
  int id;
  String productName;
  String createdAt;
  String updatedAt;
  List<Productimages> productimages;

  Seller(
      {this.id,
      this.productName,
      this.createdAt,
      this.updatedAt,
      this.productimages});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['productimages'] != null) {
      productimages = new List<Productimages>();
      json['productimages'].forEach((v) {
        productimages.add(new Productimages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.productimages != null) {
      data['productimages'] =
          this.productimages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SellerResultModel {
  List<Seller> seller;

  SellerResultModel({this.seller});

  SellerResultModel.fromJson(List<dynamic> json) {
    if (json != null) {
      seller = new List<Seller>();
      json.forEach((v) {
        seller.add(new Seller.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seller != null) {
      data['seller'] = this.seller.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
