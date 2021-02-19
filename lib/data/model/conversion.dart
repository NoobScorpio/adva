class Conversion {
  int id;
  int points;
  int amount;
  String createdAt;
  String updatedAt;

  Conversion(
      {this.id, this.points, this.amount, this.createdAt, this.updatedAt});

  Conversion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    points = json['points'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['points'] = this.points;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
