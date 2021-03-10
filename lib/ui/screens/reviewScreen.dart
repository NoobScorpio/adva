import 'dart:io';
import 'package:adva/bloc/product_bloc/getIDProductCubit.dart';
import 'package:adva/bloc/product_bloc/postReviewCubit.dart';
import 'package:adva/bloc/product_bloc/productState.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/imagesRow.dart';
import 'package:adva/ui/utils/reviewWidget.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:images_picker/images_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class ReviewScreen extends StatefulWidget {
  final bool appBar, addImage;
  final int pid, cid, first, last;
  final List<Widget> reviews;

  const ReviewScreen({
    Key key,
    this.appBar,
    this.pid,
    this.reviews,
    this.cid,
    this.addImage,
    this.first,
    this.last,
  }) : super(key: key);
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double _rating = 3;
  ImagesRow imagesRow = ImagesRow();
  ImagesRow imgRows;
  bool imageAdded = false;

  TextEditingController controller = TextEditingController();
  String message = '';
  List<Media> res = List<Media>();
  List<File> files = List<File>();
  List<Widget> reviews = [];
  Future<void> loadAssets() async {
    try {
      res = await ImagesPicker.pick(
        count: 4,
        pickType: PickType.image,
      );

      if (res.length > 0) {
        for (var reso in res) {
          files.add(File(reso.path));
        }
      }
      if (files.length == 1) {
        print('ADD IMAGE 1');
        imgRows = ImagesRow(
          img1: files[0],
          img2: null,
          img3: null,
          img4: null,
        );
      } else if (files.length == 2) {
        print('ADD IMAGE 2');
        imgRows = ImagesRow(
          img1: files[0],
          img2: files[1],
          img3: null,
          img4: null,
        );
      } else if (files.length == 3) {
        print('ADD IMAGE 3');
        imgRows = ImagesRow(
          img1: files[0],
          img2: files[1],
          img3: files[2],
          img4: null,
        );
      } else if (files.length == 4) {
        print('ADD IMAGE 4');
        imgRows = ImagesRow(
          img1: files[0],
          img2: files[1],
          img3: files[2],
          img4: files[3],
        );
      } else {
        imgRows = ImagesRow(
          img1: null,
          img2: null,
          img3: null,
          img4: null,
        );
      }
    } on Exception catch (e) {
      print('INSIDE LOAD ASSET EXCEPTION');
      print("ADD IMAGE EXCEPTION " + e.toString());
    }

    // if (!mounted) return;

    setState(() {
      print('ADD IMAGE  INSIDE SET');
      imageAdded = true;
      print('ADD IMAGE $imageAdded');
    });
  }

  @override
  void initState() {
    // TODO: implement initStat
    super.initState();

    if (widget.addImage) loadAssets();

    reviews = widget.reviews;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
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
                'Reviews',
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
                children: reviews,
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
                    controller: controller, autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Type here'.tr(),
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
                      RatingBar.builder(
                        onRatingUpdate: (rating) {
                          _rating = rating;
                          print(_rating);
                        },
                        initialRating: _rating,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        itemCount: 5,
                        itemSize: 30.0,
                        unratedColor: Colors.amber.withAlpha(50),
                        direction: Axis.horizontal,
                      ),
                      GestureDetector(
                        onTap: loadAssets,
                        child: Row(
                          children: [
                            Text(
                              'Add Image',
                              style: TextStyle(color: primaryColor),
                            ).tr(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                Icons.photo_outlined,
                                color: primaryColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (imageAdded) imgRows,
                      if (!imageAdded) imagesRow,
                      BlocListener<PostReviewCubit, ProductState>(
                        listener: (context, state) {
                          if (state is ProductPostReviewScreenState) {
                            dynamic val = state.posted;
                            if (val.runtimeType == bool) {
                              if (val) {
                                showToast('Review posted', primaryColor);
                                setState(() {
                                  reviews.add(ReviewWidget(
                                    screenwidth: screenWidth,
                                    firstName: widget.first ?? 'Anon',
                                    lastName: widget.last ?? 'Anon',
                                    rating: _rating,
                                    network: false,
                                    message: message,
                                    images: files,
                                  ));

                                  imageAdded = false;
                                });
                                files = [];
                                BlocProvider.of<GetIDProductCubit>(context)
                                    .getProduct(widget.pid);
                              } else {
                                showToast(
                                    'Could not post review', primaryColor);
                              }
                            } else {
                              showToast(val, primaryColor);
                            }
                          }
                        },
                        child: Container(
                          height: 55,
                          width: screenWidth / 2.5,
                          child: RaisedButton(
                            onPressed: () {
                              if (controller.text.length >= 10) {
                                if (files.length < 1) {
                                  showToast(
                                      'Attach at least 1 image.', primaryColor);
                                } else {
                                  message = controller.text;
                                  BlocProvider.of<PostReviewCubit>(context)
                                      .postReviewScreen(message, widget.pid, 0,
                                          _rating.toInt(), files);

                                  controller.text = '';
                                  // setState(() {
                                  //   print("FILES $files");
                                  // });
                                }
                              } else {
                                showToast(
                                    'Review should have at least 10 characters',
                                    primaryColor);
                              }
                            },
                            color: primaryColor,
                            child: Text(
                              'Submit Review',
                              style: TextStyle(color: Colors.white),
                            ).tr(),
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
