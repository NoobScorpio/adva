import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  List<String> comms = ['English', 'Arabic'];
  String comValue = 'English';
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'First Name',
                  style: boldTextStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Last Name',
                  style: boldTextStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Receive Communication in',
                  style: boldTextStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.black,
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
                          value: comValue,
                          underline: SizedBox(),
                          items: comms.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text('$value'),
                            );
                          }).toList(),
                          onChanged: (_) {
                            setState(() {
                              comValue = _;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 45,
                width: double.maxFinite,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  color: primaryColor,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
