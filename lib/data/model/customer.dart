class Customer {
  int id;
  String firstName;
  String lastName;
  String email;
  Null taxCard;
  String dob;
  String phone;
  Null confirmationCode;
  String address;
  Null profileImage;
  String token;
  String preferences;
  int points;
  Null deletedAt;
  String createdAt;
  String updatedAt;

  Customer(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.taxCard,
      this.dob,
      this.phone,
      this.confirmationCode,
      this.address,
      this.profileImage,
      this.token,
      this.preferences,
      this.points,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    taxCard = json['tax_card'];
    dob = json['dob'];
    phone = json['phone'];
    confirmationCode = json['confirmation_code'];
    address = json['address'];
    profileImage = json['profile_image'];
    token = json['token'];
    preferences = json['preferences'];
    points = json['points'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['tax_card'] = this.taxCard;
    data['dob'] = this.dob;
    data['phone'] = this.phone;
    data['confirmation_code'] = this.confirmationCode;
    data['address'] = this.address;
    data['profile_image'] = this.profileImage;
    data['token'] = this.token;
    data['preferences'] = this.preferences;
    data['points'] = this.points;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
