import 'dart:async';

import 'package:adva/bloc/returnCubit.dart';
import 'package:adva/data/model/return.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/screens/orderDetailsScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class UserReturnsScreen extends StatefulWidget {
  final User user;

  const UserReturnsScreen({Key key, this.user}) : super(key: key);
  @override
  _UserReturnsScreenState createState() => _UserReturnsScreenState();
}

class _UserReturnsScreenState extends State<UserReturnsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReturnCubit>(context).getReturns(widget.user.id);
  }

  TextEditingController searchCont = TextEditingController();
  bool search = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/advalogo.png',
          scale: 3,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    'Returns',
                    style: boldTextStyle,
                  ).tr(),
                ),
                Container(
                  height: 60,
                  child: TextFormField(
                    controller: searchCont,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter order id'.tr(),
                      suffix: !search
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  search = true;
                                  // searchCont.text = '';
                                });
                                BlocProvider.of<ReturnCubit>(context)
                                    .getReturns(widget.user.id);
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              },
                              icon: Icon(
                                Icons.search,
                                color: primaryColor,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  search = false;
                                  searchCont.text = '';
                                });
                                Timer(Duration(milliseconds: 500), () {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                BlocBuilder<ReturnCubit, ReturnState>(
                    builder: (context, state) {
                  if (state is ReturnInitialState)
                    return buildLoading();
                  else if (state is ReturnLoadingState)
                    return buildLoading();
                  else if (state is ReturnLoadedState) {
                    if (state.returns != null)
                      return getReturns(returns: state.returns);
                    else
                      return getReturns(returns: []);
                  } else if (state is ReturnErrorState)
                    return getReturns(returns: []);
                  else
                    return getReturns(returns: []);
                })
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getReturns({List<Return> returns}) {
    if (returns.length > 0) {
      List<Widget> widgets = [];
      widgets.add(SizedBox(
        height: 15,
      ));
      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('ID').tr(),
            SizedBox(
              width: 15,
            ),
            Expanded(child: Text('Date').tr()),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Return Reason').tr(),
              ],
            )),
            Text('Return Status').tr(),
          ],
        ),
      ));
      widgets.add(Divider(
        color: Colors.grey,
      ));
      for (Return turn in returns) {
        if (search) {
          print("@SEARCh $search");
          print("@SEARCh ${turn.id} and ${searchCont.text} ");
          if (turn.orderId.toString().contains(searchCont.text)) {
            widgets.add(InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => OrderDetailsScreen(
                            user: widget.user,
                            cid: widget.user.id,
                            oid: turn.orderId,
                            cart: false)));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                    width: double.maxFinite,
                    height: 60,
                    child: Card(
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${turn.orderId}',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              '${turn.updatedAt.split("T")[0]}',
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                '${turn.returnReason}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('${turn.returnStatus}'),
                          ],
                        ),
                      ),
                    )),
              ),
            ));
          }
        } else {
          widgets.add(InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => OrderDetailsScreen(
                          user: widget.user,
                          cid: widget.user.id,
                          oid: turn.orderId,
                          cart: false)));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                  width: double.maxFinite,
                  height: 60,
                  child: Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${turn.orderId}',
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            '${turn.updatedAt.split("T")[0]}',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 100,
                            child: Text(
                              '${turn.returnReason}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('${turn.returnStatus}'),
                        ],
                      ),
                    ),
                  )),
            ),
          ));
        }
      }
      return ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: widgets,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'You don\'t have any order returns.',
            style: TextStyle(color: Colors.grey),
          ).tr(),
        ),
      );
    }
  }
}
