class Payment {
  int id;
  int customerId;
  String cardBrand;
  String nameOnCard;
  String cardNumber;
  String expiryDate;
  String securityCode;
  String createdAt;
  String updatedAt;

  Payment(
      {this.id,
      this.customerId,
      this.cardBrand,
      this.nameOnCard,
      this.cardNumber,
      this.expiryDate,
      this.securityCode,
      this.createdAt,
      this.updatedAt});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    cardBrand = json['card_brand'];
    nameOnCard = json['name_on_card'];
    cardNumber = json['card_number'];
    expiryDate = json['expiry_date'];
    securityCode = json['security_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['card_brand'] = this.cardBrand;
    data['name_on_card'] = this.nameOnCard;
    data['card_number'] = this.cardNumber;
    data['expiry_date'] = this.expiryDate;
    data['security_code'] = this.securityCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PaymentResultModel {
  List<Payment> payments;

  PaymentResultModel({this.payments});

  PaymentResultModel.fromJson(List<dynamic> json) {
    if (json != null) {
      payments = List<Payment>();
      json.forEach((v) {
        payments.add(new Payment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.payments != null) {
      data['payments'] = this.payments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
