import 'package:adva/data/model/cartItem.dart';

class Cart {
  Cart._privateConstructor();
  static final _instance = Cart._privateConstructor();
  factory Cart() {
    return _instance;
  }
  List<CartItem> cartItem;

  // Cart({this.cartItem});

  Cart.fromJson(Map<String, dynamic> json) {
    if (json['CartItem'] != null) {
      cartItem = new List<CartItem>();
      json['CartItem'].forEach((v) {
        cartItem.add(new CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItem != null) {
      data['CartItem'] = this.cartItem.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
