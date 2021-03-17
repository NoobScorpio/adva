class OrderProduct {
  int id;
  int newQuantity;
  int price;

  OrderProduct({this.id, this.newQuantity, this.price});

  OrderProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    newQuantity = json['newQuantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['newQuantity'] = this.newQuantity;
    data['price'] = this.price;
    return data;
  }
}