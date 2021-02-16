import 'package:adva/data/model/productImage.dart';

class RelatedProducts {
  int id;
  List<Productimages> productimages;

  RelatedProducts({this.id, this.productimages});

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    if (this.productimages != null) {
      data['productimages'] =
          this.productimages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
