import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RefundScreen extends StatefulWidget {
  @override
  _RefundScreenState createState() => _RefundScreenState();
}

class _RefundScreenState extends State<RefundScreen> {
  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Container(
            height: 60,
            width: 60,
            child: Image.asset('assets/images/advalogo.png')),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: boldTextStyle,
                ).tr(),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Refund Preferences',
              style: boldTextStyle,
            ).tr(),
          ),
          Container(
            color: Colors.white,
            width: double.maxFinite,
            height: ht * 0.35,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.account_balance_wallet_outlined),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wallet Refund',
                          style: boldTextStyle,
                        ).tr(),
                        Text(
                            'Lorem ipsum dolor sit amet, consetetur sadipscig elitr, sed diam nonumy')
                      ],
                    ),
                    trailing: Icon(
                      Icons.check_circle,
                      color: primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Divider(),
                  ),
                  ListTile(
                    leading: Icon(Icons.credit_card_sharp),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Refund',
                          style: boldTextStyle,
                        ).tr(),
                        Text(
                            'Lorem ipsum dolor sit amet, consetetur sadipscig elitr, sed diam nonumy')
                      ],
                    ),
                    trailing: Icon(
                      Icons.circle,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
