import 'package:adva/data/model/productImage.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductImageViewScreen extends StatefulWidget {
  final List<Productimages> images;

  const ProductImageViewScreen({Key key, this.images}) : super(key: key);
  @override
  _ProductImageViewScreenState createState() => _ProductImageViewScreenState();
}

class _ProductImageViewScreenState extends State<ProductImageViewScreen> {
  String image;
  int selected = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = widget.images[0].pictureReference;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            height: 60,
            width: 60,
            child: Image.asset('assets/images/advalogo.png')),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: boldTextStyle,
                ).tr(),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$selected of ${widget.images.length}',
                      style: boldTextStyle,
                    )
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                height: 400,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(image),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.maxFinite,
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          image = widget.images[index].pictureReference;
                          selected = index + 1;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    widget.images[index].pictureReference),
                              ),
                              border: Border.all(
                                color: Colors.grey[300], // red as border color
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          // width: screenWidth - 50,
                          // height: 150,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
