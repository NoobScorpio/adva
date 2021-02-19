import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  int id;
  int pid;
  String pName;
  int price;
  int color;
  int qty;
  int size;
  String image;
  String desc;
  bool wishList;
  double discount;
  CartItem(
      {this.id,
      this.pName,
      this.pid,
      this.color,
      this.qty,
      this.size,
      this.price,
      this.image,
      this.wishList,
      this.discount,
      this.desc});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    color = json['color'];
    qty = json['qty'];
    pName = json['pName'];
    size = json['size'];
    price = json['price'];
    image = json['image'];
    desc = json['desc'];
    wishList = json['wishList'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['color'] = this.color;
    data['qty'] = this.qty;
    data['id'] = this.id;
    data['pName'] = this.pName;
    data['size'] = this.size;
    data['price'] = this.price;
    data['image'] = this.image;
    data['desc'] = this.desc;
    data['wishList'] = this.wishList;
    data['discount'] = this.discount;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          pid == other.pid &&
          pName == other.pName &&
          color == other.color &&
          price == other.price &&
          image == other.image &&
          desc == other.desc &&
          wishList == other.wishList &&
          size == other.size;

  @override
  int get hashCode =>
      pName.hashCode +
      pid.hashCode +
      color.hashCode +
      qty.hashCode +
      image.hashCode +
      size.hashCode +
      desc.hashCode +
      wishList.hashCode +
      size.hashCode;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}