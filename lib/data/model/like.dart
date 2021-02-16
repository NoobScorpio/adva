class Likes {
  int id;
  int customerId;
  int postId;
  String createdAt;
  String updatedAt;

  Likes(
      {this.id, this.customerId, this.postId, this.createdAt, this.updatedAt});

  Likes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    postId = json['post_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['post_id'] = this.postId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
