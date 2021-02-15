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
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.red,
    ),
  );
}
