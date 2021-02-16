class Qas {
  int id;
  String question;
  String answer;
  int productId;
  int customerId;
  String createdAt;
  String updatedAt;

  Qas(
      {this.id,
      this.question,
      this.answer,
      this.productId,
      this.customerId,
      this.createdAt,
      this.updatedAt});

  Qas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    productId = json['product_id'];
    customerId = json['customer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['product_id'] = this.productId;
    data['customer_id'] = this.customerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
