class CODRate {
  int id;
  dynamic charges;
  String createdAt;
  String updatedAt;

  CODRate({this.id, this.charges, this.createdAt, this.updatedAt});

  CODRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    charges = json['charges'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['charges'] = this.charges;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
