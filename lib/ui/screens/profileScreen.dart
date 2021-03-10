import 'dart:io';
import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/screens/changePasswordScreen.dart';
import 'package:adva/ui/screens/userInfoScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:images_picker/images_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key key, this.user}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.user.firstName + " " + widget.user.lastName}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 21,
                  ),
                ),
                Text(
                  widget.user.email ?? '',
                  style: normalTextStyle,
                ),
              ],
            ),
          ),
          Container(
            // height: 500,
            width: double.maxFinite,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Personal Information',
                          style: boldTextStyle,
                        ).tr(),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserInfoScreen(user: widget.user)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Edit',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: primaryColor),
                          ).tr(),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: widget.user.profileImage ==
                                          null ||
                                      widget.user.profileImage == ''
                                  ? NetworkImage(
                                      "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png")
                                  : NetworkImage('${widget.user.profileImage}'),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: CircleAvatar(
                                radius: 27,
                                backgroundColor: primaryColor,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          color: Colors.grey,
                                          spreadRadius: 1)
                                    ],
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      showToast("Uploading", primaryColor);
                                      try {
                                        List<Media> res =
                                            await ImagesPicker.pick(
                                          count: 1,
                                          pickType: PickType.image,
                                        );
                                        if (res != null && res.length > 0) {
                                          File image = File(res[0].path);

                                          bool updated =
                                              await BlocProvider.of<UserCubit>(
                                                      context)
                                                  .updateProfile(
                                                      widget.user, image);
                                          if (updated)
                                            showToast("Uploaded", primaryColor);
                                          else
                                            showToast(
                                                "Not Uploaded", primaryColor);
                                        }
                                      } catch (e) {
                                        print(e);
                                        showToast("Something went wrong",
                                            primaryColor);
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.photo,
                                        color: primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'First Name',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ).tr(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      '${widget.user.firstName ?? ""}',
                      style: boldTextStyle,
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Last Name',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ).tr(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      '${widget.user.lastName ?? ""}',
                      style: boldTextStyle,
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Receiver Communication in',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ).tr(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 10),
                    child: Text(
                      context.locale == Locale('en', '') ? "English" : "عربي",
                      style: boldTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: MyButton(
                width: double.maxFinite,
                height: 55,
                borderColor: primaryColor,
                innerColor: Colors.white,
                child: Text(
                  'Change Password',
                  style: TextStyle(color: primaryColor),
                ).tr(),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChangePasswordScreen(user: widget.user)));
                }),
          ),
        ],
      ),
    );
  }
}
