import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final color;
  final question, answer;
  final screenWidth;
  const QuestionWidget(
      {Key key, this.color, this.question, this.answer, this.screenWidth})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            // height: 150,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
              child: Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    color: color,
                    child: Center(
                      child: Text(
                        'Q',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: screenWidth - 150,
                    // height: 150,
                    child: Text(question ?? ''),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: screenWidth - 150,
            // height: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'A',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    // width: screenWidth - 150,
                    height: answer != null ? 100 : 15,
                    child: Text(answer ?? ''),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
