import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  int id;
  int pid;
  String pName;
  String arabicName;
  dynamic price;
  dynamic oldPrice;
  int color;
  dynamic vat;
  String category;
  String arabicCategory;
  int categoryID;
  int qty;
  int sizeID;
  String size;
  String image;
  String desc, arabicDesc;
  bool wishList;
  dynamic discount;
  CartItem(
      {this.id,
      this.arabicName,
      this.pName,
      this.arabicCategory,
      this.pid,
      this.oldPrice,
      this.color,
      this.category,
      this.categoryID,
      this.sizeID,
      this.qty,
      this.vat,
      this.size,
      this.price,
      this.image,
      this.wishList,
      this.discount,
      this.desc,
      this.arabicDesc});

  CartItem.fromJson(Map<String, dynamic> json) {
    arabicCategory = json['arabicCategory'];
    arabicDesc = json['arabicDesc'];
    arabicName = json['arabicName'];
    categoryID = json['categoryID'];
    sizeID = json['sizeID'];
    id = json['id'];
    pid = json['pid'];
    color = json['color'];
    qty = json['qty'];
    pName = json['pName'];
    size = json['size'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    image = json['image'];
    desc = json['desc'];
    wishList = json['wishList'];
    discount = json['discount'];
    vat = json['vat'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['arabicCategory'] = this.arabicCategory;
    data['arabicDesc'] = this.arabicDesc;
    data['arabicName'] = this.arabicName;
    data['categoryID'] = this.categoryID;
    data['sizeID'] = this.sizeID;
    data['category'] = this.category;
    data['pid'] = this.pid;
    data['color'] = this.color;
    data['qty'] = this.qty;
    data['id'] = this.id;
    data['pName'] = this.pName;
    data['size'] = this.size;
    data['price'] = this.price;
    data['oldPrice'] = this.oldPrice;
    data['image'] = this.image;
    data['desc'] = this.desc;
    data['wishList'] = this.wishList;
    data['discount'] = this.discount;
    data['vat'] = this.vat;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          pid == other.pid &&
          arabicName == other.arabicName &&
          pName == other.pName &&
          color == other.color &&
          price == other.price &&
          image == other.image &&
          desc == other.desc &&
          discount == other.discount &&
          vat == other.vat &&
          wishList == other.wishList &&
          size == other.size;

  @override
  int get hashCode =>
      pName.hashCode +
      discount.hashCode +
      vat.hashCode +
      pid.hashCode +
      color.hashCode +
      arabicName.hashCode +
      image.hashCode +
      size.hashCode +
      desc.hashCode +
      wishList.hashCode +
      size.hashCode;

  @override
  List<Object> get props => throw UnimplementedError();
}
