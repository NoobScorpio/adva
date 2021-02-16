import 'package:flutter/material.dart';

Widget buildNotFound() {
  return Center(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.hourglass_bottom),
        ),
        Text('No item found in filter')
      ],
    ),
  );
}
