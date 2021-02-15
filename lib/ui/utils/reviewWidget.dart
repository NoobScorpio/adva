import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewWidget extends StatelessWidget {
  final picture, firstName, lastName, rating, message;

  const ReviewWidget(
      {Key key,
      this.picture,
      this.firstName,
      this.lastName,
      this.rating,
      this.message})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      // height: 150,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: picture != null
                      ? Image.network(picture)
                      : Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                  radius: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Text('$firstName $lastName'),
                ),
                RatingBarIndicator(
                  rating: rating.toDouble(),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  unratedColor: Colors.amber.withAlpha(50),
                  direction: Axis.horizontal,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(message),
            ),
          ],
        ),
      ),
    );
  }
}
