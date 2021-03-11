import 'package:adva/bloc/order_bloc/orderCubit.dart';
import 'package:adva/bloc/order_bloc/orderState.dart';
import 'package:adva/data/model/orderDetails.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/screens/orderDetailsScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class UserOrdersScreen extends StatefulWidget {
  final User user;

  const UserOrdersScreen({Key key, this.user}) : super(key: key);
  @override
  _UserOrdersScreenState createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderCubit>(context).getOrders(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            height: 60,
            width: 60,
            child: Image.asset('assets/images/advalogo.png')),
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
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
                    'Orders',
                    style: boldTextStyle,
                  ).tr(),
                ),
                Container(
                  height: 60,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter order id'.tr(),
                      suffix: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: primaryColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
                  if (state is OrderInitialState)
                    return buildLoading();
                  else if (state is OrderLoadingState)
                    return buildLoading();
                  else if (state is OrderLoadedState) {
                    if (state.orderDetails != null)
                      return getOrders(orderDetails: state.orderDetails);
                    else
                      return getOrders(orderDetails: []);
                  } else if (state is OrderDetailsLoadedState) {
                    if (state.orderDetails != null)
                      return getOrders(orderDetails: state.orderDetails);
                    else
                      return getOrders(orderDetails: []);
                  } else if (state is OrderErrorState)
                    return getOrders(orderDetails: []);
                  else
                    return getOrders(orderDetails: []);
                })
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getOrders({List<OrderDetails> orderDetails}) {
    if (orderDetails.length > 0) {
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
            Expanded(child: Center(child: Text('Date').tr())),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Status').tr(),
              ],
            )),
            Text('Total').tr(),
          ],
        ),
      ));
      widgets.add(Divider(
        color: Colors.grey,
      ));
      for (OrderDetails order in orderDetails) {
        widgets.add(GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => OrderDetailsScreen(
                        user: widget.user,
                        cid: widget.user.id,
                        oid: order.id,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${order.id}',
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: Center(
                                child:
                                    Text('${order.updatedAt.split("T")[0]}'))),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              order.status == 'returned'
                                  ? Icons.keyboard_return_outlined
                                  : (order.status == 'completed'
                                      ? Icons.done
                                      : Icons.timelapse),
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('${order.status}').tr(),
                          ],
                        )),
                        Text('SAR'.tr() + '. ${order.total}'),
                      ],
                    ),
                  ),
                )),
          ),
        ));
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
            'You do not have any Orders',
            style: TextStyle(color: Colors.grey),
          ).tr(),
        ),
      );
    }
  }
}
