import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ADVAPointsScreen extends StatefulWidget {
  @override
  _ADVAPointsScreenState createState() => _ADVAPointsScreenState();
}

class _ADVAPointsScreenState extends State<ADVAPointsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            height: 60,
            width: 60,
            child: Image.asset('assets/images/advalogo.png')),
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Wallet balance',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'PTS 0.00',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Promo Code',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'DGRY6434',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                  height: 35,
                  width: 130,
                  color: primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 35,
                      width: 130,
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          'Copy Code',
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 25,
              ),
              Text(
                'Share this promo code and get reward',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 75,
              ),
              Icon(
                Icons.account_balance_wallet_outlined,
                size: 150,
                color: primaryColor.withOpacity(0.1),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'You don\'t have any Adva points',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
