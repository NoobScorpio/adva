import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, {text}) {
  return AppBar(
    leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios, color: Colors.black)),
    backgroundColor: Colors.white,
    title: Text(
      text,
      style: TextStyle(color: Colors.black),
    ),
  );
}
