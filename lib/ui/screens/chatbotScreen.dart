import 'package:adva/data/repository/miscRepo.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  TextEditingController question = TextEditingController();
  List<Widget> widgets = [];
  Widget listViewItem(quest, {right}) {
    // widget layout for listview items
    return Align(
      alignment: right ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                color: right ? primaryColor : secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("$quest",
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    widgets.add(listViewItem("How can I help you?", right: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Chatbot',
          style: TextStyle(color: Colors.white),
        ).tr(),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widgets.length,
              itemBuilder: (context, i) {
                return widgets[i]; // item layout
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: question,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                    onTap: () async {
                      setState(() {
                        widgets.add(listViewItem(question.text, right: true));
                      });
                      String answer = await MiscRepositoryImpl()
                          .getAnswer(question: question.text);
                      if (answer == "" || answer == null || answer == '""') {
                        setState(() {
                          widgets.add(listViewItem("No related query available",
                              right: false));
                        });
                      } else {
                        setState(() {
                          widgets.add(listViewItem(answer, right: false));
                        });
                      }
                      setState(() {
                        question.text = "";
                      });
                    },
                    child: Icon(
                      Icons.send,
                      color: primaryColor,
                    )),
                hintText: 'Enter question'.tr(),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
