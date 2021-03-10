import 'package:flutter/material.dart';

Widget buildErrorUi(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        message,
        style: TextStyle(color: Colors.red),
      ),
    ),
  );
}

Widget buildLoading() {
  return Padding(
    padding: const EdgeInsets.all(25.0),
    child: Center(
      child: Image.asset(
        'assets/images/loader.gif',
        scale: 3,
      ),
    ),
  );
}
