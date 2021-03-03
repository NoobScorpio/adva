class DiscountRate {
  int id;
  String discountName;
  String discountCode;
  dynamic discountPercent;
  String startDate;
  String expiryDate;
  String createdAt;
  String updatedAt;

  DiscountRate(
      {this.id,
      this.discountName,
      this.discountCode,
      this.discountPercent,
      this.startDate,
      this.expiryDate,
      this.createdAt,
      this.updatedAt});

  DiscountRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountName = json['discount_name'];
    discountCode = json['discount_code'];
    discountPercent = json['discount_percent'];
    startDate = json['start_date'];
    expiryDate = json['expiry_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['discount_name'] = this.discountName;
    data['discount_code'] = this.discountCode;
    data['discount_percent'] = this.discountPercent;
    data['start_date'] = this.startDate;
    data['expiry_date'] = this.expiryDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
