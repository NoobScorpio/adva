class Productimages {
  int id;
  int productId;
  String pictureReference;
  String createdAt;
  String updatedAt;

  Productimages(
      {this.id,
      this.productId,
      this.pictureReference,
      this.createdAt,
      this.updatedAt});

  Productimages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    pictureReference = json['picture_reference'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['picture_reference'] = this.pictureReference;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
