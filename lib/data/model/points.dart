import 'package:adva/data/model/customer.dart';

class Points {
  int id;
  int customerId;
  int points;
  String origin;
  String createdAt;
  String updatedAt;
  Customer customer;

  Points(
      {this.id,
      this.customerId,
      this.points,
      this.origin,
      this.createdAt,
      this.updatedAt,
      this.customer});

  Points.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    points = json['points'];
    origin = json['origin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['points'] = this.points;
    data['origin'] = this.origin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    return data;
  }
}
