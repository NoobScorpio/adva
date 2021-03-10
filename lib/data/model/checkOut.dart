class CheckOutInfo {
  String name;
  String email;
  int addressId;
  String phone;
  String address;
  String city;
  String country;
  String postal;
  String paymentMethod;

  CheckOutInfo(
      {this.name,
      this.addressId,
      this.email,
      this.paymentMethod,
      this.phone,
      this.address,
      this.city,
      this.country,
      this.postal});

  CheckOutInfo.fromJson(Map<String, dynamic> json) {
    addressId = json['addressId'];
    paymentMethod = json['paymentMethod'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    postal = json['postal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['addressId'] = this.addressId;
    data['paymentMethod'] = this.paymentMethod;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['postal'] = this.postal;
    return data;
  }
}
