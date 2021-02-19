import 'package:adva/data/model/brand.dart';
import 'package:adva/data/model/category.dart';
import 'package:adva/data/model/colors.dart';
import 'package:adva/data/model/productImage.dart';
import 'package:adva/data/model/qas.dart';
import 'package:adva/data/model/relatedProduct.dart';
import 'package:adva/data/model/review.dart';
import 'package:adva/data/model/sizes.dart';

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
  int weight;
  int length;
  int width;
  int height;
  String deletedAt;
  String createdAt;
  String updatedAt;
  Category category;
  List<RelatedProducts> relatedProducts;
  Brand brand;
  List<Productimages> productimages;
  List<Qas> qas;
  List<Sizes> sizes;
  List<ProductColors> colors;
  List<Reviews> reviews;

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
      this.weight,
      this.length,
      this.width,
      this.height,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.reviews,
      this.brand,
      this.productimages,
      this.qas,
      this.sizes,
      this.colors});

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

    if (json['related_products'] != null &&
        json['related_products'].runtimeType != String) {
      relatedProducts = new List<RelatedProducts>();
      json['related_products'].forEach((v) {
        relatedProducts.add(new RelatedProducts.fromJson(v));
      });
    }
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
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['reviews'] != null) {
      reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    if (json['productimages'] != null) {
      productimages = new List<Productimages>();
      json['productimages'].forEach((v) {
        productimages.add(new Productimages.fromJson(v));
      });
    }
    if (json['qas'] != null) {
      qas = new List<Qas>();
      json['qas'].forEach((v) {
        qas.add(new Qas.fromJson(v));
      });
    }
    if (json['sizes'] != null) {
      sizes = new List<Sizes>();
      json['sizes'].forEach((v) {
        sizes.add(new Sizes.fromJson(v));
      });
    }
    if (json['colors'] != null) {
      colors = new List<ProductColors>();
      json['colors'].forEach((v) {
        colors.add(new ProductColors.fromJson(v));
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
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.relatedProducts != null) {
      data['related_products'] =
          this.relatedProducts.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    if (this.productimages != null) {
      data['productimages'] =
          this.productimages.map((v) => v.toJson()).toList();
    }
    if (this.qas != null) {
      data['qas'] = this.qas.map((v) => v.toJson()).toList();
    }
    if (this.sizes != null) {
      data['sizes'] = this.sizes.map((v) => v.toJson()).toList();
    }
    if (this.colors != null) {
      data['colors'] = this.colors.map((v) => v.toJson()).toList();
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
