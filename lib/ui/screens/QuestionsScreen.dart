import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';

class QuestionsScreen extends StatefulWidget {
  final bool appBar;

  const QuestionsScreen({Key key, this.appBar}) : super(key: key);
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
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
                'Questions & Answers',
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
                        child: Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              // height: 150,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      color: primaryColor,
                                      child: Center(
                                        child: Text(
                                          'Q',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      // height: 150,
                                      child: Text(
                                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                                          'sed diam nonumy eirmod tempor invidunt ut labore et dolore'
                                          ' magna aliquyam erat, sed diam voluptua. At vero eos et '
                                          'accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, '
                                          'no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum '
                                          'dolor sit amet, consetetur sadipscing elitr, sed diam nonumy'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              // height: 150,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      color: Colors.black,
                                      child: Center(
                                        child: Text(
                                          'A',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      // height: 150,
                                      child: Text(
                                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                                          'sed diam nonumy eirmod tempor invidunt ut labore et dolore'
                                          ' magna aliquyam erat, sed diam voluptua. At vero eos et '
                                          'accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, '
                                          'no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum '
                                          'dolor sit amet, consetetur sadipscing elitr, sed diam nonumy'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              // height: 150,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      color: primaryColor,
                                      child: Center(
                                        child: Text(
                                          'Q',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      // height: 150,
                                      child: Text(
                                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                                          'sed diam nonumy eirmod tempor invidunt ut labore et dolore'
                                          ' magna aliquyam erat, sed diam voluptua. At vero eos et '
                                          'accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, '
                                          'no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum '
                                          'dolor sit amet, consetetur sadipscing elitr, sed diam nonumy'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              // height: 150,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      color: Colors.black,
                                      child: Center(
                                        child: Text(
                                          'A',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      // height: 150,
                                      child: Text(
                                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                                          'sed diam nonumy eirmod tempor invidunt ut labore et dolore'
                                          ' magna aliquyam erat, sed diam voluptua. At vero eos et '
                                          'accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, '
                                          'no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum '
                                          'dolor sit amet, consetetur sadipscing elitr, sed diam nonumy'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              // height: 150,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      color: primaryColor,
                                      child: Center(
                                        child: Text(
                                          'Q',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      // height: 150,
                                      child: Text(
                                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                                          'sed diam nonumy eirmod tempor invidunt ut labore et dolore'
                                          ' magna aliquyam erat, sed diam voluptua. At vero eos et '
                                          'accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, '
                                          'no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum '
                                          'dolor sit amet, consetetur sadipscing elitr, sed diam nonumy'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              // height: 150,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      color: Colors.black,
                                      child: Center(
                                        child: Text(
                                          'A',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      // height: 150,
                                      child: Text(
                                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                                          'sed diam nonumy eirmod tempor invidunt ut labore et dolore'
                                          ' magna aliquyam erat, sed diam voluptua. At vero eos et '
                                          'accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, '
                                          'no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum '
                                          'dolor sit amet, consetetur sadipscing elitr, sed diam nonumy'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (!widget.appBar)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuestionsScreen(
                                      appBar: true,
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: Text(
                            'ViewAll',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 160,
          width: double.maxFinite,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: double.maxFinite,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your question(s) here',
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
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Container(
                      height: 50,
                      width: screenWidth / 2.5,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        color: primaryColor,
                        child: Text(
                          'Ask a Question',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
