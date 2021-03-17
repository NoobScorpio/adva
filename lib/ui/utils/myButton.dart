import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    this.height,
    this.width,
    this.onPressed,
    this.borderColor,
    this.innerColor,
    this.child,
  }) : super();

  final double height;
  final double width;
  final Function onPressed;
  final Color borderColor, innerColor;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(border: Border.all(color: borderColor)),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Container(
            color: innerColor,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
