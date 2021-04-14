import 'dart:ui';

import 'package:adva/data/model/checkOut.dart';
import 'package:adva/data/model/discountRate.dart';
import 'package:adva/data/model/payment.dart';
import 'package:adva/data/model/promo.dart';
import 'package:adva/data/model/shipRate.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/repository/miscRepo.dart';
import 'package:adva/ui/screens/orderDetailsScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/paymentColumn.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentScreen extends StatefulWidget {
  final User user;
  final CheckOutInfo checkout;
  final dynamic shipRate;
  final dynamic total, subTotal, codRate, vat;
  const PaymentScreen(
      {Key key,
      this.user,
      this.checkout,
      this.total,
      this.subTotal,
      this.shipRate,
      this.codRate,
      this.vat})
      : super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int groupValue1 = 1, groupValue2 = 0;
  MiscRepositoryImpl miscRepo = MiscRepositoryImpl();
  TextEditingController promoCont, discountCont;
  bool promoApplied = false, discountApplied = false;
  dynamic promoValue, discountValue, overAllTotal;
  String promoCode, discountCode, pointsDiscount;
  int points;
  int pointsGroup = 0;
  @override
  void initState() {
    super.initState();
    promoCont = TextEditingController();
    discountCont = TextEditingController();
    points = widget.user.points;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Payments',
          style: TextStyle(
            color: Colors.black,
            // fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ).tr(),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Container(
            color: Colors.white,
            width: screenWidth,
            // height: screenHeight * 0.25,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method',
                    style: TextStyle(color: cartTextColor),
                  ).tr(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(border: Border.all(width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Card Payment').tr(),
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset('assets/images/visa.png'),
                                Image.asset('assets/images/mCard.png'),
                                Image.asset('assets/images/mada.png'),
                              ],
                            ),
                            Radio(
                              value: 1,
                              groupValue: groupValue1,
                              onChanged: (newValue) {
                                setState(() => groupValue1 = newValue);
                              },
                              activeColor: primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(border: Border.all(width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Cash on Delivery').tr(),
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset('assets/images/cash.png'),
                              ],
                            ),
                            Radio(
                              value: 2,
                              groupValue: groupValue1,
                              onChanged: (newValue) =>
                                  setState(() => groupValue1 = newValue),
                              activeColor: primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          //PROMO
          Container(
            color: Colors.white,
            width: screenWidth,
            // height: screenHeight * 0.19,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.02),
                    child: Text(
                      'Enter Promo Code',
                      style: boldTextStyle,
                    ).tr(),
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                      controller: promoCont,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.3, color: Colors.black),
                        ),
                      ),
                      onSaved: (String value) {},
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  InkWell(
                    onTap: () async {
                      showToast('Applying', primaryColor);
                      if (promoCont.text != '' && promoCont.text != null) {
                        Promo promo =
                            await miscRepo.getPromo(promo: promoCont.text);
                        if (promo != null) {
                          setState(() {
                            promoValue = widget.subTotal *
                                (promo.pointsForCustomer / 100);
                            promoApplied = true;
                            promoCode = promoCont.text;
                            promoCont.text = '';
                          });
                          showToast('Applied', primaryColor);
                        } else {
                          showToast('Promo not valid', primaryColor);
                        }
                      }
                    },
                    child: Container(
                      height: screenHeight * 0.06,
                      width: screenWidth * 0.3,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: primaryColor),
                      ),
                      child: Center(
                          child: Text(
                        'Apply',
                        style: TextStyle(color: primaryColor),
                      ).tr()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          //DISCOUNT
          Container(
            color: Colors.white,
            width: screenWidth,
            // height: screenHeight * 0.19,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.02),
                    child: Text(
                      'Enter Discount Code',
                      style: boldTextStyle,
                    ).tr(),
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                      controller: discountCont,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.3, color: Colors.black),
                        ),
                      ),
                      onSaved: (String value) {},
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  InkWell(
                    onTap: () async {
                      showToast('Applying', primaryColor);
                      if (discountCont.text != '' &&
                          discountCont.text != null) {
                        DiscountRate discount = await miscRepo.getDiscount(
                            discount: discountCont.text);
                        if (discount != null) {
                          var total = widget.subTotal;
                          setState(() {
                            discountValue = (total *
                                (double.parse(discount.discountPercent) / 100));
                            discountApplied = true;
                            discountCode = discountCont.text;
                            discountCont.text = '';
                          });
                          showToast('Applied', primaryColor);
                        } else {
                          showToast('Discount not valid', primaryColor);
                        }
                      }
                    },
                    child: Container(
                      height: screenHeight * 0.06,
                      width: screenWidth * 0.3,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: primaryColor),
                      ),
                      child: Center(
                          child: Text(
                        'Apply',
                        style: TextStyle(color: primaryColor),
                      ).tr()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          //POINTS
          Container(
            color: Colors.white,
            width: screenWidth,
            // height: screenHeight * 0.19,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.02, right: screenWidth * 0.02),
                    child: Text(
                      'PTS'.tr() + ': $points',
                      style: boldTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  pointsRow(screenWidth: screenWidth),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          //NEXT PAYMENT
          Container(
            color: Colors.white,
            width: screenWidth,
            // height: screenHeight * 0.3,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  getPaymentColumn(
                      tOTAL: widget.total.runtimeType == String
                          ? double.parse(widget.total)
                          : widget.total,
                      dISCOUNT: discountValue,
                      pROMO: promoValue,
                      sHIP: widget.shipRate.runtimeType == String
                          ? double.parse(widget.shipRate)
                          : widget.shipRate,
                      sUBTOTAL: widget.subTotal.runtimeType == String
                          ? double.parse(widget.subTotal)
                          : widget.subTotal),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.013),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: MyButton(
                            height: screenHeight * 0.07,
                            // width: double.maxFinite,
                            child: Text(
                              'Next',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ).tr(),
                            borderColor: Colors.transparent,
                            innerColor: primaryColor,
                            onPressed: () {
                              CheckOutInfo checkOutInfo = widget.checkout;
                              checkOutInfo.paymentMethod = groupValue1 == 1
                                  ? "CreditCardPayments"
                                  : "CashonDelivery";
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetailsScreen(
                                          personal: checkOutInfo,
                                          cart: true,
                                          promoCode:
                                              promoApplied ? promoCode : null,
                                          discountCode: discountApplied
                                              ? discountCode
                                              : null,
                                          discountValue: discountValue ?? null,
                                          promoValue: promoValue ?? null,
                                          pointsValue: pointsGroup > 0
                                              ? widget.total *
                                                  ((pointsGroup * 10) / 100)
                                              : null,
                                          pointsDiscount: pointsGroup != 0
                                              ? pointsGroup
                                              : null,
                                          total: overAllTotal,
                                          codRate: groupValue1 == 2
                                              ? widget.codRate
                                              : null,
                                          shipRate: widget.shipRate,
                                          subTotal: widget.subTotal,
                                          user: widget.user)));
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pointsRow({screenWidth}) {
    return Padding(
      padding:
          EdgeInsets.only(left: screenWidth * 0.02, right: screenWidth * 0.02),
      child: Column(
        children: [
          if (points >= 100)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('10%'),
                  Text('20%'),
                  Text('30%'),
                  Text('40%'),
                  Text('50%'),
                ],
              ),
            ),
          if (points < 100)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '10%',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '20%',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '30%',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '40%',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '50%',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          if (points < 100)
            Center(
              child: Icon(
                Icons.lock,
                color: Colors.grey,
              ),
            ),
          if (points >= 100)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Radio(
                  value: 1,
                  groupValue: pointsGroup,
                  onChanged: (val) {
                    setState(() {
                      if (points >= 100)
                        pointsGroup = val;
                      else
                        showToast('Not enough points', primaryColor);
                    });
                  },
                ),
                Radio(
                  value: 2,
                  groupValue: pointsGroup,
                  onChanged: (val) {
                    setState(() {
                      if (points >= 200)
                        pointsGroup = val;
                      else
                        showToast('Not enough points', primaryColor);
                    });
                  },
                ),
                Radio(
                  value: 3,
                  groupValue: pointsGroup,
                  onChanged: (val) {
                    setState(() {
                      if (points >= 300)
                        pointsGroup = val;
                      else
                        showToast('Not enough points', primaryColor);
                    });
                  },
                ),
                Radio(
                  value: 4,
                  groupValue: pointsGroup,
                  onChanged: (val) {
                    setState(() {
                      if (points >= 400)
                        pointsGroup = val;
                      else
                        showToast('Not enough points', primaryColor);
                    });
                  },
                ),
                Radio(
                  value: 5,
                  groupValue: pointsGroup,
                  onChanged: (val) {
                    setState(() {
                      if (points >= 500)
                        pointsGroup = val;
                      else
                        showToast('Not enough points', primaryColor);
                    });
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget getPaymentColumn({tOTAL, sUBTOTAL, dISCOUNT, pROMO, sHIP}) {
    print("@PAY INTERNATIONAL $sHIP");
    if (pROMO != null && dISCOUNT != null) {
      print("@PAY PROMO--DISCOUNT $pROMO--$dISCOUNT--$tOTAL");
      tOTAL = tOTAL - pROMO - dISCOUNT + sHIP;
    } else if (pROMO == null && dISCOUNT != null) {
      tOTAL = tOTAL - dISCOUNT + sHIP;
      print("@PAY DISCOUNT $dISCOUNT--$tOTAL");
    } else if (pROMO != null && dISCOUNT == null) {
      tOTAL = tOTAL - pROMO + sHIP;
      print("@PAY PROMO $pROMO--$tOTAL");
    } else if (pROMO == null && dISCOUNT == null) {
      tOTAL = tOTAL + sHIP;
      print("@PAY $tOTAL");
    }
    dynamic points;
    if (pointsGroup > 0) {
      dynamic total = widget.total;
      setState(() {
        points = sUBTOTAL * (pointsGroup / 10);

        tOTAL = tOTAL - points;
      });
    }
    if (groupValue1 == 2) {
      tOTAL = tOTAL + widget.codRate;
    }
    print("@POINTS SUB $sUBTOTAL points ${pointsGroup / 10} = $points");
    overAllTotal = tOTAL;
    return PaymentColumn(
      subTotal: sUBTOTAL,
      total: tOTAL,
      promo: pROMO,
      discount: dISCOUNT,
      flatShippingRate: sHIP,
      points: points,
      codRate: groupValue1 == 2 ? widget.codRate : null,
    );
  }

  Widget paymentWidgets({List<Payment> payments}) {
    if (payments.length > 0) {
      List<Widget> widgets = [];
      List<String> cards = ['Visa', 'Master', 'Mada'];
      for (Payment payment in payments) {
        String image = payment.cardBrand == cards[0]
            ? 'visa'
            : (payment.cardBrand == cards[1] ? 'mCard' : 'mada');
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 30,
                width: 50,
                child: Image.asset("/assets/images/$image.png"),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Address ${payment.nameOnCard}'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${payment.cardNumber}',
                    style: normalTextStyle,
                    maxLines: 3,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${payment.expiryDate}'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${payment.securityCode}.',
                    style: normalTextStyle,
                    maxLines: 3,
                  )
                ],
              ),
              Radio(
                value: payment.id,
                groupValue: groupValue2,
                activeColor: primaryColor,
                onChanged: (val) {
                  setState(() {
                    groupValue2 = val;
                  });
                },
              ),
            ],
          ),
        ));
      }
      return Container(
        height: widgets.length == 1 ? 120 : (widgets.length == 2 ? 220 : (300)),
        child: ListView(
          children: widgets,
        ),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('You have no payments saved.'),
      ),
    );
  }
}
