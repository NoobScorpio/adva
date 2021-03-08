class Category {
  int id;
  String categoryName;
  String categoryArabicName;
  String description;
  String arabicDescription;
  int status;
  String banner;
  String createdAt;
  String updatedAt;

  Category(
      {this.id,
      this.categoryName,
      this.categoryArabicName,
      this.description,
      this.arabicDescription,
      this.status,
      this.banner,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryArabicName = json['category_arabic_name'];
    description = json['description'];
    arabicDescription = json['arabic_description'];
    status = json['status'];
    banner = json['banner'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['category_arabic_name'] = this.categoryArabicName;
    data['description'] = this.description;
    data['arabic_description'] = this.arabicDescription;
    data['status'] = this.status;
    data['banner'] = this.banner;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CategoryResultModel {
  List<Category> categories;

  CategoryResultModel({this.categories});

  CategoryResultModel.fromJson(List<dynamic> json) {
    if (json != null) {
      categories = List<Category>();
      json.forEach((v) {
        categories.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
