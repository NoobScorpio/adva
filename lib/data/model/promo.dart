class Promo {
  int id;
  int customerId;
  String promoCode;
  int pointsForUser;
  int pointsForCustomer;
  String dateStart;
  String dateEnd;
  String createdAt;
  String updatedAt;

  Promo(
      {this.id,
      this.customerId,
      this.promoCode,
      this.pointsForUser,
      this.pointsForCustomer,
      this.dateStart,
      this.dateEnd,
      this.createdAt,
      this.updatedAt});

  Promo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    promoCode = json['promo_code'];
    pointsForUser = json['points_for_user'];
    pointsForCustomer = json['points_for_customer'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['promo_code'] = this.promoCode;
    data['points_for_user'] = this.pointsForUser;
    data['points_for_customer'] = this.pointsForCustomer;
    data['date_start'] = this.dateStart;
    data['date_end'] = this.dateEnd;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
