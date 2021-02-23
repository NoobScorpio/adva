class Return {
  int id;
  int orderId;
  int customerId;
  String returnReason;
  String returnStatus;
  String createdAt;
  String updatedAt;

  Return(
      {this.id,
      this.orderId,
      this.customerId,
      this.returnReason,
      this.returnStatus,
      this.createdAt,
      this.updatedAt});

  Return.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    customerId = json['customer_id'];
    returnReason = json['return_reason'];
    returnStatus = json['return_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['customer_id'] = this.customerId;
    data['return_reason'] = this.returnReason;
    data['return_status'] = this.returnStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ReturnResultModel {
  List<Return> returns;

  ReturnResultModel({this.returns});

  ReturnResultModel.fromJson(List<dynamic> json) {
    if (json != null) {
      returns = List<Return>();
      json.forEach((v) {
        returns.add(new Return.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.returns != null) {
      data['returns'] = this.returns.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
