import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ConfirmAddressScreen extends StatefulWidget {
  @override
  _ConfirmAddressScreenState createState() => _ConfirmAddressScreenState();
}

class _ConfirmAddressScreenState extends State<ConfirmAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                height: 80,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 15),
                      child: Container(
                          height: 60,
                          width: 60,
                          child: Image.asset('assets/images/advalogo.png')),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, right: 20),
                        child: Text(
                          'Cancel',
                          style: boldTextStyle,
                        ).tr(),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Location Information',
                  style: boldTextStyle,
                ).tr(),
              ),
              Container(
                width: double.maxFinite,
                height: 260,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    child: Text(
                                      '3585 - Al Batraji - AZ Zahra District - Jeddah - Makkah Makkah Province'.tr(),
                                      style: boldTextStyle,
                                      maxLines: 4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Al Qatar',
                                style: TextStyle(fontSize: 16),
                              ).tr(),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                              child: Column(
                                children: [
                                  Container(
                                      height: 90,
                                      width: 90,
                                      child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Image.asset(
                                              'assets/images/advabeauty.png'))),
                                  Text(
                                    'Edit',
                                    style: TextStyle(color: Colors.blue),
                                  ).tr(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Additional Label (Optional)').tr(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            label: Text('Home').tr(),
                            backgroundColor: Colors.white,
                            shadowColor: primaryColor,
                            elevation: 5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            label: Text('Office').tr(),
                            backgroundColor: Colors.white,
                            // shadowColor: primaryColor,
                            elevation: 5,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MyButton(
              height: 55,
              width: double.maxFinite,
              onPressed: () {
                Navigator.pop(context, true);
              },
              innerColor: primaryColor,
              borderColor: Colors.transparent,
              child: Text(
                'Save Address',
                style: TextStyle(color: Colors.white),
              ).tr(),
            ),
          )
        ],
      ),
    );
  }
}
