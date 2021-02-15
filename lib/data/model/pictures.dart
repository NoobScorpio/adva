class Pictures {
  int id;
  int reviewId;
  String picture;
  String createdAt;
  String updatedAt;

  Pictures(
      {this.id, this.reviewId, this.picture, this.createdAt, this.updatedAt});

  Pictures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reviewId = json['review_id'];
    picture = json['picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['review_id'] = this.reviewId;
    data['picture'] = this.picture;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
