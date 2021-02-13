import 'package:adva/data/model/brand.dart';
import 'package:adva/data/model/category.dart';
import 'package:adva/data/model/productImage.dart';

class Product {
  int id;
  String productName;
  int categoryId;
  int brandId;
  int quantity;
  String productDescription;
  int price;
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
  String createdAt;
  String updatedAt;
  Category category;
  Brand brand;
  List<Productimages> productimages;

  Product(
      {this.id,
      this.productName,
      this.categoryId,
      this.brandId,
      this.quantity,
      this.productDescription,
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
      this.createdAt,
      this.updatedAt,
      this.category,
      this.brand,
      this.productimages});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    quantity = json['quantity'];
    productDescription = json['product_description'];
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
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
    data['category_id'] = this.categoryId;
    data['brand_id'] = this.brandId;
    data['quantity'] = this.quantity;
    data['product_description'] = this.productDescription;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    if (this.productimages != null) {
      data['productimages'] =
          this.productimages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductResultModel {
  List<Product> products;

  ProductResultModel({this.products});

  ProductResultModel.fromJson(List<dynamic> json) {
    if (json != null) {
      products = List<Product>();
      json.forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
