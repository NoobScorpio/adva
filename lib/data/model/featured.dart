import 'package:adva/data/model/productImage.dart';

class Featured {
  int id;
  String productName;
  String createdAt;
  String updatedAt;
  int price;
  String productDescription;
  List<Productimages> productimages;

  Featured(
      {this.id,
      this.productName,
      this.createdAt,
      this.updatedAt,
      this.productimages});

  Featured.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    price = json['price'];
    productDescription = json['product_description'];
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
    data['product_description'] = this.productDescription;
    data['price'] = this.price;
    if (this.productimages != null) {
      data['productimages'] =
          this.productimages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedResultModel {
  List<Featured> featured;

  FeaturedResultModel({this.featured});

  FeaturedResultModel.fromJson(List<dynamic> json) {
    if (json != null) {
      featured = new List<Featured>();
      json.forEach((v) {
        featured.add(new Featured.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.featured != null) {
      data['featured'] = this.featured.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
