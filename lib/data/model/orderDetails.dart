class OrderDetails {
  int id;
  int customerId;
  String country;
  String address;
  String city;
  int postalCode;
  String paymentMethod;
  int couponCode;
  String giftVoucher;
  String firstName;
  String lastName;
  String email;
  String phone;
  int total;
  String orderFrom;
  int gift;
  int staffId;
  String createdAt;
  String updatedAt;
  String status;

  OrderDetails(
      {this.id,
      this.customerId,
      this.country,
      this.address,
      this.city,
      this.postalCode,
      this.paymentMethod,
      this.couponCode,
      this.giftVoucher,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.total,
      this.orderFrom,
      this.gift,
      this.staffId,
      this.createdAt,
      this.updatedAt,
      this.status});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    country = json['country'];
    address = json['address'];
    city = json['city'];
    postalCode = json['postal_code'];
    paymentMethod = json['payment_method'];
    couponCode = json['coupon_code'];
    giftVoucher = json['gift_voucher'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    total = json['total'];
    orderFrom = json['order_from'];
    gift = json['gift'];
    staffId = json['staff_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['country'] = this.country;
    data['address'] = this.address;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['payment_method'] = this.paymentMethod;
    data['coupon_code'] = this.couponCode;
    data['gift_voucher'] = this.giftVoucher;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['total'] = this.total;
    data['order_from'] = this.orderFrom;
    data['gift'] = this.gift;
    data['staff_id'] = this.staffId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}

class OrderDetailsResultModel {
  List<OrderDetails> orderDetails;

  OrderDetailsResultModel({this.orderDetails});

  OrderDetailsResultModel.fromJson(List<dynamic> json) {
    if (json != null) {
      orderDetails = List<OrderDetails>();
      json.forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
