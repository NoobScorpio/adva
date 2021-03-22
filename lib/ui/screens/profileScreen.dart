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
  _ProfileScreenState createState() => _ProfileScreenState(user);
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user;
  String photoUrl;

  _ProfileScreenState(this.user);

  @override
  void initState() {
    super.initState();

    photoUrl = user.profileImage;
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
                  '${user.firstName + " " + user.lastName}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 21,
                  ),
                ),
                Text(
                  user.email ?? '',
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
                                      UserInfoScreen(user: user)));
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
                              backgroundImage: photoUrl == null ||
                                      photoUrl == ''
                                  ? NetworkImage(
                                      "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png")
                                  : NetworkImage('$photoUrl'),
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
                                      try {
                                        List<Media> res =
                                            await ImagesPicker.pick(
                                          count: 1,
                                          pickType: PickType.image,
                                          cropOpt: CropOption(
                                            aspectRatio: CropAspectRatio.custom,
                                            cropType: CropType
                                                .rect, // currently for android
                                          ),
                                        );
                                        if (res != null && res.length > 0) {
                                          File image = File(res[0].path);
                                          showToast("Uploading", primaryColor);
                                          User updated =
                                              await BlocProvider.of<UserCubit>(
                                                      context)
                                                  .updateProfile(
                                                      widget.user, image);
                                          if (updated != null) {
                                            showToast("Uploaded", primaryColor);
                                            setState(() {
                                              user = updated;
                                              photoUrl = user.profileImage;
                                            });
                                          } else
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
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ).tr(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      '${user.firstName ?? ""}',
                      style: boldTextStyle,
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Last Name',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ).tr(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      '${user.lastName ?? ""}',
                      style: boldTextStyle,
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Receiver Communication in',
                      style: TextStyle(
                          color: Colors.black54,
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
            padding: EdgeInsets.only(
                top: 25.0,
                bottom: 25.0,
                left: 25.0,
                right: MediaQuery.of(context).size.width / 2.65),
            child: Container(
              // width: MediaQuery.of(context).size.width / 2,
              child: MyButton(
                  // width: MediaQuery.of(context).size.width / 2,
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
          ),
        ],
      ),
    );
  }
}
