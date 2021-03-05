import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:easy_localization/easy_localization.dart';

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
        if (image == null)
          CircleAvatar(
              backgroundColor: primaryColor,
              radius: 25.0,
              child: Icon(
                Icons.person,
                color: Colors.white,
              )),
        if (image != null)
          CircleAvatar(
            backgroundColor: primaryColor,
            radius: 25.0,
            backgroundImage: NetworkImage(image),
          ),
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
                    name ?? "Anonymous".tr(),
                    style: boldTextStyle,
                  ),
                  SizedBox(
                    width: 10,
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
