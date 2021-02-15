import 'package:adva/data/model/customer.dart';
import 'package:adva/data/model/pictures.dart';

class Reviews {
  int id;
  int customerId;
  int productId;
  int stars;
  String reviewMessage;
  String createdAt;
  String updatedAt;
  Customer customer;
  List<Pictures> pictures;

  Reviews(
      {this.id,
      this.customerId,
      this.productId,
      this.stars,
      this.reviewMessage,
      this.createdAt,
      this.updatedAt,
      this.customer,
      this.pictures});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    stars = json['stars'];
    reviewMessage = json['review_message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['pictures'] != null) {
      pictures = new List<Pictures>();
      json['pictures'].forEach((v) {
        pictures.add(new Pictures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['product_id'] = this.productId;
    data['stars'] = this.stars;
    data['review_message'] = this.reviewMessage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    if (this.pictures != null) {
      data['pictures'] = this.pictures.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
