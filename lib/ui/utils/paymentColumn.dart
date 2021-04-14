import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentColumn extends StatelessWidget {
  const PaymentColumn(
      {Key key,
      this.flatShippingRate,
      this.subTotal,
      this.total,
      this.promo,
      this.discount,
      this.points,
      this.codRate})
      : super(key: key);

  final dynamic flatShippingRate,
      subTotal,
      total,
      promo,
      discount,
      points,
      codRate;
  @override
  Widget build(BuildContext context) {
    print("@PAYMENT  TYPE ${total.runtimeType}");
    return Column(
      children: [
        //SHIPPING RATE
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Flat Shipping Rate',
                  style: TextStyle(
                    fontSize: 15,
                  )).tr(),
              Row(
                children: [
                  Text('SAR',
                      style: TextStyle(
                        fontSize: 15,
                      )).tr(),
                  Text('. ${flatShippingRate.toString() ?? ""}',
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ],
              ),
            ],
          ),
        ),
        //SUBTOTAL RATE
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sub Total',
                  style: TextStyle(
                    fontSize: 15,
                  )).tr(),
              Row(
                children: [
                  Text('SAR',
                      style: TextStyle(
                        fontSize: 15,
                      )).tr(),
                  Text(
                      '. ${subTotal == null ? 0.0 : subTotal.toString() ?? ""}',
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ],
              ),
            ],
          ),
        ),

        //PROMO RATE
        if (promo != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Promo',
                        style: TextStyle(fontSize: 15, color: primaryColor))
                    .tr(),
                Row(
                  children: [
                    Text('SAR',
                        style: TextStyle(
                          fontSize: 15,
                        )).tr(),
                    Text(
                        '. ${promo.runtimeType == String ? double.parse(promo).toStringAsPrecision(5).toString() : (promo.runtimeType == int ? promo : promo.toStringAsPrecision(5).toString())}',
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ],
                ),
              ],
            ),
          ),
        //PROMO RATE
        if (codRate != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cash On Delivery',
                        style: TextStyle(fontSize: 15, color: primaryColor))
                    .tr(),
                Row(
                  children: [
                    Text('SAR',
                        style: TextStyle(
                          fontSize: 15,
                        )).tr(),
                    Text(
                        '. ${codRate.runtimeType == String ? double.parse(codRate).toStringAsPrecision(3).toString() : (codRate.runtimeType == int ? codRate : codRate.toStringAsPrecision(3).toString())}',
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ],
                ),
              ],
            ),
          ),
        //DISCOUNT RATE
        if (discount != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Discount',
                        style: TextStyle(fontSize: 15, color: primaryColor))
                    .tr(),
                Row(
                  children: [
                    Text('SAR',
                        style: TextStyle(
                          fontSize: 15,
                        )).tr(),
                    Text(
                        '. ${discount.runtimeType == String ? double.parse(discount).toStringAsPrecision(5).toString() : (discount.runtimeType == int ? discount : discount.toStringAsPrecision(5).toString())}',
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ],
                ),
              ],
            ),
          ),
        //POINTS RATE
        if (points != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('PTS', style: TextStyle(fontSize: 15, color: primaryColor))
                    .tr(),
                Row(
                  children: [
                    Text('SAR',
                        style: TextStyle(
                          fontSize: 15,
                        )).tr(),
                    Text(
                        '. ${points.runtimeType == String ? double.parse(points).toStringAsPrecision(5).toString() : (points.runtimeType == int ? points : points.toStringAsPrecision(5).toString())}',
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ],
                ),
              ],
            ),
          ),
        //TOTAL RATE
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: TextStyle(fontSize: 15, color: primaryColor))
                  .tr(),
              Row(
                children: [
                  Text('SAR',
                      style: TextStyle(
                        fontSize: 15,
                      )).tr(),
                  Text(
                      '. ${total.runtimeType == String ? (total == null ? 0.0 : double.parse(total).toStringAsPrecision(5).toString()) : (total == null ? 0.0 : (total.runtimeType == int ? total : total.toStringAsPrecision(5).toString()))}',
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
