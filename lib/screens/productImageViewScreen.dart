import 'package:adva/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductImageViewScreen extends StatefulWidget {
  @override
  _ProductImageViewScreenState createState() => _ProductImageViewScreenState();
}

class _ProductImageViewScreenState extends State<ProductImageViewScreen> {
  @override
  Widget build(BuildContext context) {
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
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '1 of 4',
                      style: boldTextStyle,
                    )
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                height: 400,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset('assets/images/eye.png'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.maxFinite,
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 140,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset('assets/images/eye.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 140,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset('assets/images/eye.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 140,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset('assets/images/eye.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 140,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset('assets/images/eye.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
