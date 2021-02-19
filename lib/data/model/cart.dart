import 'package:adva/data/model/product.dart';

class Cart {
  int id;
  int productId;
  int orderId;
  int quantity;
  int price;
  double total;
  int subTotal;
  String color;
  String size;
  String createdAt;
  String updatedAt;
  Product product;

  Cart(
      {this.id,
      this.productId,
      this.orderId,
      this.quantity,
      this.price,
      this.total,
      this.subTotal,
      this.color,
      this.size,
      this.createdAt,
      this.updatedAt,
      this.product});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    orderId = json['order_id'];
    quantity = json['quantity'];
    price = json['price'];
    total = json['total'];
    subTotal = json['sub_total'];
    color = json['color'];
    size = json['size'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['order_id'] = this.orderId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['total'] = this.total;
    data['sub_total'] = this.subTotal;
    data['color'] = this.color;
    data['size'] = this.size;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}
