import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewScreen extends StatefulWidget {
  final bool appBar;

  const ReviewScreen({Key key, this.appBar}) : super(key: key);
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double _rating = 3;
  @override
  Widget build(BuildContext context) {
    return widget.appBar
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Reviews',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: body(context))
        : Scaffold(
            body: body(context),
          );
  }

  Widget body(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    radius: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8.0),
                                    child: Text('Demo User'),
                                  ),
                                  RatingBarIndicator(
                                    rating: _rating,
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
                              Text(
                                  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                                  'sed diam nonumy eirmod tempor invidunt ut labore et dolore'
                                  ' magna aliquyam erat, sed diam voluptua. At vero eos et '
                                  'accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, '
                                  'no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum '
                                  'dolor sit amet, consetetur sadipscing elitr, sed diam nonumy'),
                            ],
                          ),
                        ),
                      ),
                      Container(
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
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    radius: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8.0),
                                    child: Text('Demo User'),
                                  ),
                                  RatingBarIndicator(
                                    rating: _rating,
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
                              Text(
                                  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                                  'sed diam nonumy eirmod tempor invidunt ut labore et dolore'
                                  ' magna aliquyam erat, sed diam voluptua. At vero eos et '
                                  'accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, '
                                  'no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum '
                                  'dolor sit amet, consetetur sadipscing elitr, sed diam nonumy'),
                            ],
                          ),
                        ),
                      ),
                      Container(
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
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    radius: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8.0),
                                    child: Text('Demo User'),
                                  ),
                                  RatingBarIndicator(
                                    rating: _rating,
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
                              Text(
                                  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                                  'sed diam nonumy eirmod tempor invidunt ut labore et dolore'
                                  ' magna aliquyam erat, sed diam voluptua. At vero eos et '
                                  'accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, '
                                  'no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum '
                                  'dolor sit amet, consetetur sadipscing elitr, sed diam nonumy'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // if (!widget.appBar)
                  //   GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => ReviewScreen(
                  //                     appBar: true,
                  //                   )));
                  //     },
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(15.0),
                  //       child: Center(
                  //         child: Text(
                  //           'ViewAll',
                  //           style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold,
                  //               color: primaryColor,
                  //               decoration: TextDecoration.underline),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 210,
          width: double.maxFinite,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: double.maxFinite,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type here',
                      suffix: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.send,
                          color: primaryColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    // autofillHints: ['Type your comment here'],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBarIndicator(
                        rating: _rating,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        itemCount: 5,
                        itemSize: 30.0,
                        unratedColor: Colors.amber.withAlpha(50),
                        direction: Axis.horizontal,
                      ),
                      Row(
                        children: [
                          Text(
                            'Add Image',
                            style: TextStyle(color: primaryColor),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.photo_outlined,
                              color: primaryColor,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.photo_outlined,
                            color: Colors.grey,
                            size: 35,
                          ),
                          Icon(
                            Icons.photo_outlined,
                            color: Colors.grey,
                            size: 35,
                          ),
                          Icon(
                            Icons.photo_outlined,
                            color: Colors.grey,
                            size: 35,
                          ),
                          Icon(
                            Icons.photo_outlined,
                            color: Colors.grey,
                            size: 35,
                          ),
                        ],
                      ),
                      Container(
                        height: 55,
                        width: screenWidth / 2.5,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          color: primaryColor,
                          child: Text(
                            'Submit Review',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
