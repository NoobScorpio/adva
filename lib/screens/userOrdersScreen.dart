import 'package:adva/utils/constants.dart';
import 'package:flutter/material.dart';

class UserOrdersScreen extends StatefulWidget {
  @override
  _UserOrdersScreenState createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    'Orders',
                    style: boldTextStyle,
                  ),
                ),
                Container(
                  height: 60,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter order id',
                      suffix: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: primaryColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Text('ID')),
                    Expanded(child: Text('ID')),
                    Expanded(child: Text('ID')),
                    Text('ID'),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                      width: double.maxFinite,
                      height: 60,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: Text(
                                'ID-12312',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline),
                              )),
                              Expanded(child: Text('12/05/2020')),
                              Expanded(
                                  child: Row(
                                children: [
                                  Icon(
                                    Icons.timelapse,
                                    size: 15,
                                  ),
                                  Text('Pending'),
                                ],
                              )),
                              Text('SAR. 999'),
                            ],
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                      width: double.maxFinite,
                      height: 60,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: Text(
                                'ID-12312',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline),
                              )),
                              Expanded(child: Text('12/05/2020')),
                              Expanded(
                                  child: Row(
                                children: [
                                  Icon(
                                    Icons.timelapse,
                                    size: 15,
                                  ),
                                  Text('Pending'),
                                ],
                              )),
                              Text('SAR. 999'),
                            ],
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                      width: double.maxFinite,
                      height: 60,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: Text(
                                'ID-12312',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline),
                              )),
                              Expanded(child: Text('12/05/2020')),
                              Expanded(
                                  child: Row(
                                children: [
                                  Icon(
                                    Icons.timelapse,
                                    size: 15,
                                  ),
                                  Text('Pending'),
                                ],
                              )),
                              Text('SAR. 999'),
                            ],
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                      width: double.maxFinite,
                      height: 60,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: Text(
                                'ID-12312',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline),
                              )),
                              Expanded(child: Text('12/05/2020')),
                              Expanded(
                                  child: Row(
                                children: [
                                  Icon(
                                    Icons.timelapse,
                                    size: 15,
                                  ),
                                  Text('Pending'),
                                ],
                              )),
                              Text('SAR. 999'),
                            ],
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                      width: double.maxFinite,
                      height: 60,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: Text(
                                'ID-12312',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline),
                              )),
                              Expanded(child: Text('12/05/2020')),
                              Expanded(
                                  child: Row(
                                children: [
                                  Icon(
                                    Icons.timelapse,
                                    size: 15,
                                  ),
                                  Text('Pending'),
                                ],
                              )),
                              Text('SAR. 999'),
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
