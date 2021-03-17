class OrderReturnProduct {
  int productId;
  dynamic price;
  int quantity;
  dynamic total;

  OrderReturnProduct({this.productId, this.price, this.quantity, this.total});

  OrderReturnProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    price = json['price'];
    quantity = json['quantity'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    return data;
  }
}
