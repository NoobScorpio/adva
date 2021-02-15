class CartItem {
  int id;
  int pid;
  String pName;
  int color;
  int qty;

  CartItem({this.pid, this.color, this.qty});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    color = json['color'];
    qty = json['qty'];
    pName = json['pName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['color'] = this.color;
    data['qty'] = this.qty;
    data['id'] = this.id;
    data['pName'] = this.pName;
    return data;
  }
}
