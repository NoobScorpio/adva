class Products {
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
  dynamic discountedAmount;
  String relatedProducts;
  dynamic costPrice;
  dynamic tax;
  dynamic vat;
  String sku;
  String model;
  String barcode;
  int timer;
  String timerFrom;
  String timerTo;
  int featured;
  dynamic shipping;
  dynamic weight;
  dynamic length;
  dynamic width;
  dynamic height;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  int isBundle;
  // Pivot pivot;

  Products({
    this.id,
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
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.isBundle,
    // this.pivot
  });

  Products.fromJson(Map<String, dynamic> json) {
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
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isBundle = json['is_bundle'];
    // pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_bundle'] = this.isBundle;
    // if (this.pivot != null) {
    //   data['pivot'] = this.pivot.toJson();
    // }
    return data;
  }
}

class Pivot {
  int offerId;
  int productId;

  Pivot({this.offerId, this.productId});

  Pivot.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offer_id'] = this.offerId;
    data['product_id'] = this.productId;
    return data;
  }
}
