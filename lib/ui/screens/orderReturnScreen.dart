import 'package:adva/bloc/order_bloc/orderCubit.dart';
import 'package:adva/data/model/orderDetail.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/repository/orderRepo.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/paymentColumn.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:adva/data/model/returnOrderProduct.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  List<OrderReturnProduct> ids = [];
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
        ).tr(),
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
                    alignment: context.locale == Locale('en', '')
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Text(
                      'Order ID'.tr() + ': ${orderDetail.id}',
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
                  ).tr(),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    width: double.maxFinite,
                    child: TextField(
                      keyboardType: TextInputType.text,
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
                onPressed: () async {
                  showToast('Returning order', primaryColor);
                  if (returnReason.length >= 10) {
                    bool returned = await OrderRepositoryImpl().returnOrder(
                        oid: orderDetail.id,
                        ids: ids,
                        reason: returnReason,
                        cid: orderDetail.customerId);

                    if (returned != null && returned == true) {
                      showToast('Order Returned', primaryColor);
                      int count = 0;
                      await BlocProvider.of<OrderCubit>(context)
                          .getOrders(widget.user.id);
                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
                    } else {
                      showToast('Something went wrong', primaryColor);
                    }
                  } else
                    showToast(
                        'Please enter at least 10 characters', primaryColor);
                },
                color: primaryColor,
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ).tr(),
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
    print("@ORDER RETUrN LENGTH${orderDetail.cart.length}");
    print("@ORDER RETUrN 0 PRice ${orderDetail.cart[0].total}");
    print("@ORDER RETUrN IDS len ${ids.length}");
    for (int i = 0; i < orderDetail.cart.length; i++) {
      for (int j = 0; j < ids.length; j++) {
        if (ids[j].productId == orderDetail.cart[i].id) {
          total += orderDetail.cart[i].total;
          subTotal += orderDetail.cart[i].subTotal;
        }
      }
    }
    print("@ORDER RETUrN $total");
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
                      if (orderDetail.cart[i].product != null &&
                          orderDetail.cart[i].product.productimages.length != 0)
                        Container(
                          height: 70,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(orderDetail.cart[i].product
                                    .productimages[0].pictureReference),
                              ),
                              border: Border.all(
                                color: Colors.grey[300], // red as border color
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          width: 70,
                        ),
                      if (!(orderDetail.cart[i].product != null &&
                          orderDetail.cart[i].product.productimages.length !=
                              0))
                        Container(
                          height: 70,
                          width: 70,
                          child: Center(
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
                            "${context.locale == Locale('en', '') ? orderDetail.cart[i].product.productName : orderDetail.cart[i].product.productArabicName}",
                            style: boldTextStyle,
                          ).tr(),
                          SizedBox(
                            height: 5,
                          ),
                          Text("${orderDetail.cart[i].product != null && orderDetail.cart[i].product.category != null ? (context.locale == Locale('en', '') ? orderDetail.cart[i].product.category.categoryName : orderDetail.cart[i].product.category.categoryArabicName) : "Category".tr()} ")
                              .tr(),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "SAR".tr() + ". ${orderDetail.cart[i].total}",
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Quantity".tr() +
                              " ${orderDetail.cart[i].quantity ?? "?"}"),
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
                          ids.add(OrderReturnProduct(
                              productId: orderDetail.cart[i].id,
                              price: orderDetail.cart[i].price,
                              quantity: orderDetail.cart[i].quantity,
                              total: orderDetail.cart[i].total));
                        } else {
                          for (int i = 0; i < orderDetail.cart.length; i++) {
                            for (int j = 0; j < ids.length; j++) {
                              if (ids[j].productId == orderDetail.cart[i].id) {
                                ids.removeAt(j);
                              }
                            }
                          }

                          // if (ids.contains(orderDetail.cart[i].id)) {
                          //   ids.remove(orderDetail.cart[i]);
                          // }
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
