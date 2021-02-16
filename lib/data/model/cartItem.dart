class CartItem {
  int id;
  int pid;
  String pName;
  int color;
  int qty;
  int size;
  CartItem({this.pid, this.color, this.qty, this.size});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    color = json['color'];
    qty = json['qty'];
    pName = json['pName'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['color'] = this.color;
    data['qty'] = this.qty;
    data['id'] = this.id;
    data['pName'] = this.pName;
    data['size'] = this.size;
    return data;
  }
}
