import 'package:adva/data/model/product.dart';

class Order {
  int customerId;
  String id;
  dynamic total;
  String email;
  int addressId;
  String paymentType;
  String promoCode;
  String discountCode;
  int pointsDiscount;
  String phone;
  bool isMobile;
  List<Product> products;

  Order(
      {this.customerId,
      this.total,
      this.id,
      this.isMobile,
      this.email,
      this.addressId,
      this.phone,
      this.products,
      this.paymentType,
      this.promoCode,
      this.discountCode,
      this.pointsDiscount});

  Order.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    isMobile = json['is_mobile'];
    id = json['id'];
    total = json['total'];
    phone = json['phone'];
    email = json['email'];
    addressId = json['address_id'];
    paymentType = json['payment_type'];
    promoCode = json['promo_code'];
    discountCode = json['discount_code'];
    pointsDiscount = json['points_discount'];
    if (json['products'] != null) {
      products = new List<Product>();
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId.toString();
    data['phone'] = this.phone;
    data['id'] = this.id;
    data['total'] = this.total.toString();
    data['email'] = this.email;
    data['address_id'] = this.addressId.toString();
    data['payment_type'] = this.paymentType;
    data['promo_code'] = this.promoCode;
    data['discount_code'] = this.discountCode;
    data['points_discount'] = this.pointsDiscount.toString();
    data['is_mobile'] = this.isMobile;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
