import 'package:flutter/material.dart';

import 'constants.dart';

class Comment extends StatelessWidget {
  final image, name, body;
  const Comment({
    Key key,
    this.image,
    this.name,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(radius: 25.0, backgroundImage: AssetImage(image)),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              width: double.maxFinite,
              color: commentBGColor,
              height: 75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: boldTextStyle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    body,
                    style: normalTextStyle,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
