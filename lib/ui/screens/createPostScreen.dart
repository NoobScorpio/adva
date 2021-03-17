import 'dart:io';
import 'package:adva/bloc/gallery_bloc/postCubit.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class CreatePostScreen extends StatefulWidget {
  final File image;
  final User user;

  const CreatePostScreen({Key key, this.image, this.user}) : super(key: key);
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String desc = '';
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
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
          'Create Post',
          style: TextStyle(color: Colors.black),
        ).tr(),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Description'.tr(),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    onChanged: (val) {
                      desc = val;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: screenWidth,
                      height: screenHeight * 0.5,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.file(widget.image),
                      )),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  MyButton(
                    borderColor: Colors.transparent,
                    innerColor: primaryColor,
                    height: 60,
                    width: screenWidth,
                    child: Text(
                      'Post',
                      style: TextStyle(color: Colors.white),
                    ).tr(),
                    onPressed: () async {
                      if (desc != '') {
                        showToast('Posting', primaryColor);
                        bool posted = await BlocProvider.of<PostsCubit>(context)
                            .postMedia(widget.image, desc, widget.user.id);
                        if (posted) {
                          showToast('Posted', primaryColor);
                          Navigator.pop(context);
                        } else {
                          showToast('Not Posted', primaryColor);
                        }
                      } else
                        showToast("Description is required", primaryColor);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
