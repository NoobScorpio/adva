import 'package:flutter/material.dart';

class ImagesRow extends StatelessWidget {
  final img1, img2, img3, img4;

  ImagesRow({this.img1, this.img2, this.img3, this.img4});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (img1 == null)
          Icon(
            Icons.photo_outlined,
            color: Colors.grey,
            size: 35,
          ),
        if (img1 != null)
          Container(
            height: 35,
            width: 35,
            child: Image.file(img1),
          ),
        if (img2 == null)
          Icon(
            Icons.photo_outlined,
            color: Colors.grey,
            size: 35,
          ),
        if (img2 != null)
          Container(
            height: 35,
            width: 35,
            child: Image.file(img2),
          ),
        if (img3 == null)
          Icon(
            Icons.photo_outlined,
            color: Colors.grey,
            size: 35,
          ),
        if (img3 != null)
          Container(
            height: 35,
            width: 35,
            child: Image.file(img3),
          ),
        if (img4 == null)
          Icon(
            Icons.photo_outlined,
            color: Colors.grey,
            size: 35,
          ),
        if (img4 != null)
          Container(
            height: 35,
            width: 35,
            child: Image.file(img4),
          ),
      ],
    );
  }
}
