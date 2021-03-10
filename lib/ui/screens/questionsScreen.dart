import 'package:adva/bloc/product_bloc/postQuestionCubit.dart';
import 'package:adva/bloc/product_bloc/productState.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/questionWidget.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class QuestionsScreen extends StatefulWidget {
  final bool appBar;
  final int pid, cid;
  final List<Widget> questions;
  const QuestionsScreen(
      {Key key, this.appBar, this.pid, this.cid, this.questions})
      : super(key: key);
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  String questionBody = '';
  TextEditingController questionController = TextEditingController();
  // ProductBloc productBloc;
  List<Widget> questions = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // productBloc = BlocProvider.of<ProductBloc>(context);
    questions = widget.questions;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    questionController.dispose();
    // productBloc.close();
  }

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
              ).tr(),
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
                    children: questions,
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
                          ).tr(),
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
                    controller: questionController,
                    decoration: InputDecoration(
                      hintText: 'Type your question(s) here'.tr(),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    // autofillHints: ['Type your comment here'],
                  ),
                ),
                BlocListener<PostQuestionCubit, ProductState>(
                  listener: (context, state) {
                    if (state is ProductPostQuestionScreenState) {
                      if (state.posted) {
                        showToast('Question Posted', primaryColor);
                        setState(() {
                          questions.add(QuestionWidget(
                            screenWidth: screenWidth,
                            color: primaryColor,
                            question: questionBody,
                            answer: '',
                          ));
                        });
                      } else
                        showToast('Question not Posted', primaryColor);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Container(
                        height: 50,
                        width: screenWidth / 2.5,
                        child: RaisedButton(
                          onPressed: () {
                            if (questionController.text.length >= 10) {
                              print('EVENT');
                              BlocProvider.of<PostQuestionCubit>(context)
                                  .postQuestionScreen(
                                      widget.pid, questionController.text, 0);
                              questionBody = questionController.text;
                              questionController.text = '';
                            } else {
                              showToast(
                                  'Question should have at least 10 characters',
                                  primaryColor);
                            }
                          },
                          color: primaryColor,
                          child: Text(
                            'Ask Question',
                            style: TextStyle(color: Colors.white),
                          ).tr(),
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
