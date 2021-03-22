import 'package:adva/bloc/points_bloc/pointsCubit.dart';
import 'package:adva/bloc/points_bloc/pointsState.dart';
import 'package:adva/data/model/advaPoints.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adva/data/model/points.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

class ADVAPointsScreen extends StatefulWidget {
  final User user;

  const ADVAPointsScreen({Key key, this.user}) : super(key: key);
  @override
  _ADVAPointsScreenState createState() => _ADVAPointsScreenState();
}

class _ADVAPointsScreenState extends State<ADVAPointsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PointsCubit>(context).getPoints(widget.user.id);
  }

  String promo = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: context.locale == Locale('en', '')
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Image.asset(
              'assets/images/advalogo.png',
              scale: 2.5,
            )),
        leading: GestureDetector(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Wallet balance',
                  style: TextStyle(color: Colors.grey),
                ).tr(),
                BlocBuilder<PointsCubit, PointsState>(
                  builder: (context, state) {
                    if (state is PointsInitialState)
                      return buildLoading();
                    else if (state is PointsLoadingState)
                      return buildLoading();
                    else if (state is PointsLoadedState) {
                      if (state.aDVAPoints != null) {
                        promo = state.aDVAPoints.promo == null
                            ? "No code"
                            : state.aDVAPoints.promo.promoCode;
                        return Text(
                          "PTS".tr() + ' ${state.aDVAPoints.total}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        );
                      } else
                        return Text(
                          "PTS".tr() + ' 0.00',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ).tr();
                    } else if (state is PointsErrorState)
                      return Text(
                        "PTS".tr() + ' 0.00',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ).tr();
                    else
                      return Text(
                        "PTS".tr() + ' 0.00',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ).tr();
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  'Promo Code',
                  style: TextStyle(color: Colors.grey),
                ).tr(),
                BlocBuilder<PointsCubit, PointsState>(
                  builder: (context, state) {
                    if (state is PointsInitialState)
                      return buildLoading();
                    else if (state is PointsLoadingState)
                      return buildLoading();
                    else if (state is PointsLoadedState) {
                      if (state.aDVAPoints != null &&
                          state.aDVAPoints.promo != null)
                        return Text(
                          '${state.aDVAPoints.promo.promoCode}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        );
                      else
                        return Text(
                          'No Code',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ).tr();
                    } else if (state is PointsErrorState)
                      return Text(
                        'No Code',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ).tr();
                    else
                      return Text(
                        'No Code',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ).tr();
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(new ClipboardData(text: promo));
                    showToast("Copied", primaryColor);
                  },
                  child: Container(
                      height: 35,
                      width: 130,
                      color: primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          height: 35,
                          width: 130,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              'Copy Code',
                              style: TextStyle(color: primaryColor),
                            ).tr(),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Share this promo code and get reward',
                  style: TextStyle(color: Colors.grey),
                ).tr(),
                SizedBox(
                  height: 75,
                ),
                BlocBuilder<PointsCubit, PointsState>(
                  builder: (context, state) {
                    if (state is PointsInitialState)
                      return buildLoading();
                    else if (state is PointsLoadingState)
                      return buildLoading();
                    else if (state is PointsLoadedState) {
                      if (state.aDVAPoints != null)
                        return getPoints(aDVAPoints: state.aDVAPoints);
                      else
                        return getPoints(aDVAPoints: null);
                    } else if (state is PointsErrorState)
                      return getPoints(aDVAPoints: null);
                    else
                      return getPoints(aDVAPoints: null);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getPoints({ADVAPoints aDVAPoints}) {
    if (aDVAPoints != null &&
        aDVAPoints.points != null &&
        aDVAPoints.points.length != 0) {
      List<Widget> widgets = [];
      widgets.add(SizedBox(
        height: 15,
      ));
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: Text('ID').tr()),
          Expanded(child: Center(child: Text('Date').tr())),
          Expanded(child: Center(child: Text('Origin').tr())),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Points').tr(),
            ],
          )),
        ],
      ));
      widgets.add(Divider(
        color: Colors.grey,
      ));
      for (Points point in aDVAPoints.points) {
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
              width: double.maxFinite,
              height: 80,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Text(
                        '${point.id}',
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline),
                      )),
                      Expanded(child: Text('${point.createdAt.split('T')[0]}')),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Center(
                              child: Text('${point.origin}', maxLines: 2))),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${point.points}'),
                        ],
                      )),
                    ],
                  ),
                ),
              )),
        ));
      }
      return ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: widgets,
      );
    } else {
      return Column(
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 150,
            color: primaryColor.withOpacity(0.1),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'You don\'t have any Adva points',
            style: TextStyle(color: Colors.grey),
          ).tr(),
        ],
      );
    }
  }
}
