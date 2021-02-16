import 'package:adva/data/model/customer.dart';

class Comments {
  int id;
  int postId;
  int customerId;
  String comment;
  String createdAt;
  String updatedAt;
  Customer customer;

  Comments(
      {this.id,
      this.postId,
      this.customerId,
      this.comment,
      this.createdAt,
      this.updatedAt,
      this.customer});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    customerId = json['customer_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['customer_id'] = this.customerId;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    return data;
  }
}
