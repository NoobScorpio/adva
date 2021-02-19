import 'package:adva/data/model/product.dart';

class WishList {
  int id;
  int customerId;
  int productId;
  String createdAt;
  String updatedAt;
  Product product;

  WishList(
      {this.id,
      this.customerId,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.product});

  WishList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['products'] != null
        ? new Product.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['products'] = this.product.toJson();
    }
    return data;
  }
}

class WishListResultModel {
  List<WishList> wishLists;

  WishListResultModel({this.wishLists});

  WishListResultModel.fromJson(List<dynamic> json) {
    if (json != null) {
      wishLists = List<WishList>();
      json.forEach((v) {
        wishLists.add(new WishList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wishLists != null) {
      data['wishLists'] = this.wishLists.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
