import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewWidget extends StatelessWidget {
  final profile,
      firstName,
      lastName,
      rating,
      message,
      images,
      network,
      screenwidth;

  const ReviewWidget(
      {Key key,
      this.profile,
      this.firstName,
      this.lastName,
      this.rating,
      this.message,
      this.images,
      this.network,
      this.screenwidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("REVIEW IMAGES == ${images[0].pictureReference}");
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
                  child: profile == null
                      ? Icon(
                          Icons.person,
                          color: Colors.white,
                        )
                      : Image.network(profile),
                  radius: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Text(
                      '${firstName == null ? '' : firstName} ${lastName == null ? '' : lastName}'),
                ),
                RatingBarIndicator(
                  rating: rating == null ? 4.0 : rating.toDouble(),
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
              child: Text(message ?? ''),
            ),
            if (images.length > 0)
              Container(
                // width: screenwidth - 100,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ReviewImage(
                      network: network,
                      image: images[0],
                    ),
                    // if (images.length > 1)
                    //   ReviewImage(
                    //     network: network,
                    //     image: images[1],
                    //   ),
                    // if (images.length > 2)
                    //   ReviewImage(
                    //     network: network,
                    //     image: images[2],
                    //   ),
                    // if (images.length > 3)
                    //   ReviewImage(
                    //     network: network,
                    //     image: images[3],
                    //   ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ReviewImage extends StatelessWidget {
  final image, network;
  const ReviewImage({
    Key key,
    this.image,
    this.network,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: network
                      ? (image.pictureReference == null
                          ? Icon(
                              Icons.image,
                              color: primaryColor,
                            )
                          : Image.network(image.pictureReference))
                      : Image.file(image),
                );
              });
        },
        child: Container(
          height: 50,
          // width: 50,
          child: FittedBox(
            fit: BoxFit.cover,
            child: network
                ? (image.pictureReference == null
                    ? Icon(
                        Icons.image,
                        color: primaryColor,
                      )
                    : Image.network(image.pictureReference))
                : Image.file(image),
          ),
        ));
  }
}
