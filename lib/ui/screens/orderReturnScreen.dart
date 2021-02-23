import 'package:adva/data/model/cart.dart';
import 'package:adva/data/model/orderDetail.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/paymentColumn.dart';
import 'package:flutter/material.dart';

class OrderReturnScreen extends StatefulWidget {
  final User user;
  final OrderDetail orderDetail;

  const OrderReturnScreen({Key key, this.user, this.orderDetail})
      : super(key: key);
  @override
  _OrderReturnScreenState createState() => _OrderReturnScreenState();
}

class _OrderReturnScreenState extends State<OrderReturnScreen> {
  List<bool> bools = [];
  OrderDetail orderDetail;
  String returnReason = '';
  List<int> ids = [];
  @override
  Widget build(BuildContext context) {
    orderDetail = widget.orderDetail;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Return Order',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                // shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Order ID: ${orderDetail.id}',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                  getProducts(orderDetail),
                  SizedBox(
                    height: 15,
                  ),
                  getPrices(orderDetail),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Return Reason',
                    style: TextStyle(color: primaryColor),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    width: double.maxFinite,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      onChanged: (val) {
                        returnReason = val;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 55,
              child: RaisedButton(
                onPressed: () async {},
                color: primaryColor,
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getPrices(OrderDetail orderDetail) {
    dynamic total = 0.0;
    dynamic subTotal = 0.0;
    for (int i = 0; i < orderDetail.cart.length; i++) {
      if (ids.contains(orderDetail.cart[i].id)) {
        total += orderDetail.cart[i].total;
        subTotal += orderDetail.cart[i].subTotal;
      }
    }
    return PaymentColumn(
      total: total.toString(),
      flatShippingRate: '10',
      subTotal: subTotal.toString(),
    );
  }

  Widget getProducts(OrderDetail orderDetail) {
    if (orderDetail.cart != null && orderDetail.cart.length != 0) {
      List<Widget> widgets = [];

      for (int i = 0; i < orderDetail.cart.length; i++) {
        bools.add(false);
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        child: orderDetail.cart[i].product != null &&
                                orderDetail
                                        .cart[i].product.productimages.length !=
                                    0
                            ? FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(orderDetail.cart[i].product
                                    .productimages[0].pictureReference),
                              )
                            : Center(
                                child: Icon(
                                  Icons.image,
                                  color: Colors.grey,
                                ),
                              ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${orderDetail.cart[i].product.productName}",
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              "${orderDetail.cart[i].product != null && orderDetail.cart[i].product.category != null ? orderDetail.cart[i].product.category.categoryName : "Category"} / ${orderDetail.cart[i].size ?? "Size"}"),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "SAR. ${orderDetail.cart[i].total}",
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              "Quantity ${orderDetail.cart[i].quantity ?? "?"}"),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Checkbox(
                      value: bools[i],
                      onChanged: (val) {
                        setState(() {
                          bools[i] = !bools[i];
                        });
                        if (bools[i]) {
                          ids.add(orderDetail.cart[i].id);
                        } else {
                          if (ids.contains(orderDetail.cart[i].id)) {
                            ids.remove(orderDetail.cart[i].id);
                          }
                        }
                      },
                      checkColor: Colors.white,
                      activeColor: primaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
      }
      return Column(
        children: widgets,
      );
    } else
      return SizedBox(
        height: 15,
      );
  }
}
