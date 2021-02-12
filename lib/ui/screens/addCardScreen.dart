import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';

class AddCardScreen extends StatefulWidget {
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  int _groupValue = 1;
  bool checkBoxValue = false;
  List<String> cards = ['Visa', 'Master', 'Mada'];
  String cardName = 'Visa';
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        title: Text(
          'Add Card',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Container(
            color: Colors.white,
            width: screenWidth,
            // height: screenHeight * 0.16,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method',
                    style: TextStyle(color: primaryColor, fontSize: 18),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.017, bottom: screenHeight * 0.01),
                    child: Container(
                      height: screenHeight * 0.08,
                      decoration: BoxDecoration(border: Border.all(width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Image.asset('assets/images/visa2.png'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 39),
                              child:
                                  Image.asset('assets/images/mastercard2.png'),
                            ),
                            Text('Card Payment'),
                            SizedBox(
                              width: screenWidth * 0.18,
                            ),
                            Radio(
                              value: 1,
                              groupValue: _groupValue,
                              onChanged: (newValue) =>
                                  setState(() => _groupValue = newValue),
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
            height: screenHeight * 0.029,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              color: Colors.white,
              width: screenWidth,
              // height: screenHeight * 0.315,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Details',
                    style: TextStyle(color: primaryColor, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Card Name',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.grey,
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        color: Colors.white,
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down,
                            ),
                            iconSize: 42,
                            value: cardName,
                            underline: SizedBox(),
                            items: cards.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text('$value'),
                              );
                            }).toList(),
                            onChanged: (_) {
                              setState(() {
                                cardName = _;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Card Number',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: screenHeight * 0.06,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      onSaved: (String value) {},
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailContainerRow(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          txt: 'Expiry Date'),
                      SizedBox(
                        width: 10,
                      ),
                      DetailContainerRow(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          txt: 'Security Code'),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: checkBoxValue,
                          activeColor: primaryColor,
                          onChanged: (bool newValue) {
                            setState(() {
                              checkBoxValue = newValue;
                            });
                            Text('Remember me');
                          }),
                      Text(
                        'Save payment method',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
            child: Text(
              'Or',
              style: TextStyle(fontSize: 19, color: Colors.black),
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: screenHeight * 0.080,
              color: primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    'Scan Card',
                    style: TextStyle(color: primaryColor),
                  )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: screenHeight * 0.080,
              color: primaryColor,
              child: Center(
                  child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailContainerRow extends StatelessWidget {
  const DetailContainerRow({
    Key key,
    @required this.screenWidth,
    @required this.screenHeight,
    this.txt,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            txt,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: screenHeight * 0.06,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.always,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onSaved: (String value) {},
            ),
          ),
        ],
      ),
    );
  }
}
