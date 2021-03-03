class TaxRate {
  dynamic taxValue;
  int withProducts;
  int withShipping;

  TaxRate({this.taxValue, this.withProducts, this.withShipping});

  TaxRate.fromJson(Map<String, dynamic> json) {
    taxValue = json['tax_value'];
    withProducts = json['with_products'];
    withShipping = json['with_shipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax_value'] = this.taxValue;
    data['with_products'] = this.withProducts;
    data['with_shipping'] = this.withShipping;
    return data;
  }
}
