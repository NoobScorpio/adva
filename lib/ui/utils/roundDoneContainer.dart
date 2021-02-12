import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';

class RoundDoneContainer extends StatelessWidget {
  const RoundDoneContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Icon(
          Icons.done,
          color: Colors.white,
          size: 13,
        ),
      ),
    );
  }
}
