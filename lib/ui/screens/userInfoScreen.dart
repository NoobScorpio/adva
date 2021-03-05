import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class UserInfoScreen extends StatefulWidget {
  final User user;

  const UserInfoScreen({Key key, this.user}) : super(key: key);
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  List<String> comms = ['English', 'Arabic'];
  TextEditingController lName, fName;
  String comValue = 'English';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lName = TextEditingController();
    fName = TextEditingController();
    lName.text = widget.user.lastName;
    fName.text = widget.user.firstName;
  }

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
                ).tr(),
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
                ).tr(),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: fName,
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
                ).tr(),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: lName,
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
                ).tr(),
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
                  onPressed: () async {
                    if (fName.text != '' && lName.text != "") {
                      User user = widget.user;
                      user.firstName = fName.text;
                      user.lastName = lName.text;
                      print("${user.id} ${user.firstName} ${user.lastName}");
                      print("${user.profileImage} ${user.email} ${user.name}");
                      print("${user.phone} ${user.points} ");
                      bool updated = await BlocProvider.of<UserCubit>(context)
                          .updateInfo(user);
                      if (updated) {
                        showToast("Info updated", primaryColor);
                        Navigator.pop(context, true);
                      } else {
                        showToast("Info not updated", primaryColor);
                      }
                    } else {
                      showToast('Please fill all fields', primaryColor);
                    }
                  },
                  color: primaryColor,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ).tr(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
