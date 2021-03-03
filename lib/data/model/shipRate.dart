class ShipRate {
  int id;
  dynamic shippingRate;
  int status;
  String createdAt;
  String updatedAt;
  int freeShipping;

  ShipRate(
      {this.id,
      this.shippingRate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.freeShipping});

  ShipRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shippingRate = json['shipping_rate'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    freeShipping = json['free_shipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shipping_rate'] = this.shippingRate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['free_shipping'] = this.freeShipping;
    return data;
  }
}
