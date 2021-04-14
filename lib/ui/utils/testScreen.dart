import 'package:adva/bloc/ads_bloc/adsBloc.dart';
import 'package:adva/bloc/ads_bloc/adsEvent.dart';
import 'package:adva/bloc/ads_bloc/adsState.dart';
import 'package:adva/data/model/ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 150.0),
        child: Column(
          children: [
            Text("HEIGHT: ${MediaQuery.of(context).size.height}"),
            Text("WIDTH: ${MediaQuery.of(context).size.width}"),
          ],
        ),
      ),
    ));
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildAds(List<Ads> ads) {
    return ListView.builder(
      itemCount: ads == null ? 0 : ads.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: ClipOval(
                child: Hero(
                  tag: ads[pos].media,
                  child: Image.network(
                    ads[pos].media,
                    fit: BoxFit.cover,
                    height: 70.0,
                    width: 70.0,
                  ),
                ),
              ),
              title: Text("${ads[pos].id}").tr(),
              subtitle: Text(ads[pos].type).tr(),
            ),
            // onTap: () {
            //   navigateToArticleDetailPage(context, articles[pos]);
            // },
          ),
        );
      },
    );
  }
}
