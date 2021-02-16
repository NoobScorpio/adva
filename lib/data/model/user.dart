class User {
  String name;
  String email;
  String firstName;
  String lastName;
  String phone;
  int id;
  String profileImage;
  String token;
  int points;

  User(
      {this.name,
      this.email,
      this.firstName,
      this.lastName,
      this.phone,
      this.id,
      this.profileImage,
      this.token,
      this.points});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    id = json['id'];
    profileImage = json['profile_image'];
    token = json['token'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['id'] = this.id;
    data['profile_image'] = this.profileImage;
    data['token'] = this.token;
    data['points'] = this.points;
    return data;
  }
}
