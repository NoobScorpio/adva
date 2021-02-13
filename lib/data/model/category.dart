class Category {
  int id;
  String categoryName;
  String description;
  int status;
  String banner;
  String createdAt;
  String updatedAt;

  Category(
      {this.id,
      this.categoryName,
      this.description,
      this.status,
      this.banner,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    description = json['description'];
    status = json['status'];
    banner = json['banner'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['description'] = this.description;
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
