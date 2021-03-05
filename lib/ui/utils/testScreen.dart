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
  AdsBloc adsBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adsBloc = BlocProvider.of<AdsBloc>(context);
    adsBloc.add(FetchAdsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Cricket"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      adsBloc.add(FetchAdsEvent());
                    },
                  ),
                ],
              ),
              body: Container(
                child: BlocBuilder<AdsBloc, AdsState>(
                  builder: (context, state) {
                    if (state is AdsInitialState) {
                      return buildLoading();
                    } else if (state is AdsLoadingState) {
                      return buildLoading();
                    } else if (state is AdsLoadedState) {
                      // return buildAds(state.ads);
                      return Text('');
                    } else if (state is AdsErrorState) {
                      return buildErrorUi(state.message);
                    } else {
                      return buildErrorUi('LAST ELSE');
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
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
