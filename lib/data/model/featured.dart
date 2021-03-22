import 'package:adva/data/model/productImage.dart';

class Featured {
  int id;
  String productName;
  String productArabicName;
  int categoryId;
  int brandId;
  int quantity;
  String productDescription;
  String productArabicDescription;
  dynamic price;
  String rewardPoints;
  int discountedAmount;
  String relatedProducts;
  int costPrice;
  int tax;
  int vat;
  String sku;
  String model;
  String barcode;
  int timer;
  String timerFrom;
  String timerTo;
  int featured;
  int shipping;
  Null weight;
  Null length;
  Null width;
  Null height;
  int offerQuantity;
  Null deletedAt;
  String createdAt;
  String updatedAt;
  List<Productimages> productimages;

  Featured(
      {this.id,
      this.productName,
      this.productArabicName,
      this.categoryId,
      this.brandId,
      this.quantity,
      this.productDescription,
      this.productArabicDescription,
      this.price,
      this.rewardPoints,
      this.discountedAmount,
      this.relatedProducts,
      this.costPrice,
      this.tax,
      this.vat,
      this.sku,
      this.model,
      this.barcode,
      this.timer,
      this.timerFrom,
      this.timerTo,
      this.featured,
      this.shipping,
      this.weight,
      this.length,
      this.width,
      this.height,
      this.offerQuantity,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.productimages});

  Featured.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productArabicName = json['product_arabic_name'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    quantity = json['quantity'];
    productDescription = json['product_description'];
    productArabicDescription = json['product_arabic_description'];
    price = json['price'];
    rewardPoints = json['reward_points'];
    discountedAmount = json['discounted_amount'];
    relatedProducts = json['related_products'];
    costPrice = json['cost_price'];
    tax = json['tax'];
    vat = json['vat'];
    sku = json['sku'];
    model = json['model'];
    barcode = json['barcode'];
    timer = json['timer'];
    timerFrom = json['timer_from'];
    timerTo = json['timer_to'];
    featured = json['featured'];
    shipping = json['shipping'];
    weight = json['weight'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    offerQuantity = json['offer_quantity'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['product_name'] = this.productName;
    data['product_arabic_name'] = this.productArabicName;
    data['category_id'] = this.categoryId;
    data['brand_id'] = this.brandId;
    data['quantity'] = this.quantity;
    data['product_description'] = this.productDescription;
    data['product_arabic_description'] = this.productArabicDescription;
    data['price'] = this.price;
    data['reward_points'] = this.rewardPoints;
    data['discounted_amount'] = this.discountedAmount;
    data['related_products'] = this.relatedProducts;
    data['cost_price'] = this.costPrice;
    data['tax'] = this.tax;
    data['vat'] = this.vat;
    data['sku'] = this.sku;
    data['model'] = this.model;
    data['barcode'] = this.barcode;
    data['timer'] = this.timer;
    data['timer_from'] = this.timerFrom;
    data['timer_to'] = this.timerTo;
    data['featured'] = this.featured;
    data['shipping'] = this.shipping;
    data['weight'] = this.weight;
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['offer_quantity'] = this.offerQuantity;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.productimages != null) {
      data['productimages'] =
          this.productimages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedResultModel {
  List<Featured> featured;

  FeaturedResultModel({this.featured});

  FeaturedResultModel.fromJson(List<dynamic> json) {
    if (json != null) {
      featured = new List<Featured>();
      json.forEach((v) {
        featured.add(new Featured.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.featured != null) {
      data['featured'] = this.featured.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
