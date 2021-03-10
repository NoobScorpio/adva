class Brand {
  int id;
  String brandName;
  String brandArabicName;
  String image;
  int featured;
  String createdAt;
  String updatedAt;

  Brand(
      {this.id,
      this.brandArabicName,
      this.brandName,
      this.image,
      this.featured,
      this.createdAt,
      this.updatedAt});

  Brand.fromJson(Map<String, dynamic> json) {
    brandArabicName = json['brand_arabic_name'];
    id = json['id'];
    brandName = json['brand_name'];
    image = json['image'];
    featured = json['featured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['brand_arabic_name'] = this.brandArabicName;
    data['id'] = this.id;
    data['brand_name'] = this.brandName;
    data['image'] = this.image;
    data['featured'] = this.featured;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class BrandResultModel {
  List<Brand> brands;

  BrandResultModel({this.brands});

  BrandResultModel.fromJson(List<dynamic> json) {
    if (json != null) {
      brands = List<Brand>();
      json.forEach((v) {
        brands.add(new Brand.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.brands != null) {
      data['brands'] = this.brands.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
