class SearchProduct {
  int id;
  String productName;

  SearchProduct({this.id, this.productName});

  SearchProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    return data;
  }
}

class SearchProductResultModel {
  List<SearchProduct> searchProduct;

  SearchProductResultModel({this.searchProduct});

  SearchProductResultModel.fromJson(List<dynamic> json) {
    if (json != null) {
      searchProduct = new List<SearchProduct>();
      json.forEach((v) {
        searchProduct.add(new SearchProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchProduct != null) {
      data['searchProduct'] =
          this.searchProduct.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
