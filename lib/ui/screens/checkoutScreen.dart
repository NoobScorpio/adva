import 'package:adva/bloc/address_bloc/addressCubit.dart';
import 'package:adva/bloc/address_bloc/addressState.dart';
import 'package:adva/bloc/cart_bloc/cartCubit.dart';
import 'package:adva/bloc/cart_bloc/cartState.dart';
import 'package:adva/data/model/address.dart';
import 'package:adva/data/model/checkOut.dart';
import 'package:adva/data/model/codRate.dart';
import 'package:adva/data/model/shipRate.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/repository/miscRepo.dart';
import 'file:///C:/Users/CIFER/AndroidStudioProjects/adva/lib/ui/screens/paymentScreen.dart';
import 'package:adva/ui/screens/addAddressScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/paymentColumn.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class CheckoutScreen extends StatefulWidget {
  final User user;
  final shipRate;
  const CheckoutScreen({Key key, this.user, this.shipRate}) : super(key: key);
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool checkBoxValue = false;
  TextEditingController name, email, phone;
  String ads = '', country = '', city = '', postal = '', label = '';
  int groupValue = 0, addressId;
  @override
  void initState() {
    super.initState();

    BlocProvider.of<AddressCubit>(context).getAddresses(widget.user.id);
    name = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    name.text = widget.user.name;
    email.text = widget.user.email;
    phone.text = widget.user.phone;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            'Check Out',
            style: TextStyle(color: Colors.black),
          ).tr(),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Back to cart',
                      style: boldTextStyle,
                    ).tr(),
                  ),
                ),
              ],
            )
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Personal Information',
                      style: boldTextStyle,
                    ).tr(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Full Name',
                      style: normalTextStyle,
                    ).tr(),
                  ),
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      hintText: 'Enter your full name'.tr(),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    onChanged: (val) {
                      // name = val;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'E-mail address',
                      style: normalTextStyle,
                    ).tr(),
                  ),
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                      hintText: 'Enter your email'.tr(),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    onChanged: (val) {
                      // email = val;
                    },
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: checkBoxValue,
                          activeColor: Colors.black,
                          onChanged: (bool newValue) {
                            setState(() {
                              checkBoxValue = newValue;
                            });
                            Text('Remember me').tr();
                          }),
                      Text('Keep me up date with exclusive offers').tr(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Phone no',
                      style: normalTextStyle,
                    ).tr(),
                  ),
                  TextField(
                    controller: phone,
                    decoration: InputDecoration(
                      hintText: 'Enter Phone no'.tr(),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    onChanged: (val) {
                      // phone = val;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Container(
              // height: screenHeight * 0.29,
              width: screenWidth,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.017,
                  left: screenWidth * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'Shipping Address',
                      ).tr(),
                    ),
                    BlocConsumer<AddressCubit, AddressState>(
                        listener: (context, state) {
                      if (state is AddressLoadedState) {
                        if (state.address != null &&
                            state.address.length != 0) {
                          setState(() {
                            groupValue = state.address[0].id;
                          });
                        }
                      }
                      if (state is AddressAddState) {
                        if (state.address != null &&
                            state.address.length != 0) {
                          setState(() {
                            groupValue = state.address[0].id;
                          });
                        }
                      }
                      if (state is AddressDeleteState) {
                        if (state.address != null &&
                            state.address.length != 0) {
                          setState(() {
                            groupValue = state.address[0].id;
                          });
                        }
                      }
                    }, builder: (context, state) {
                      if (state is AddressLoadingState) return buildLoading();
                      if (state is AddressLoadingState)
                        return addresses(addresses: []);
                      if (state is AddressLoadedState) {
                        if (state.address != null) {
                          return addresses(addresses: state.address);
                        } else
                          return addresses(addresses: []);
                      }
                      if (state is AddressAddState) {
                        if (state.address != null) {
                          return addresses(addresses: state.address);
                        } else
                          return addresses(addresses: []);
                      }
                      if (state is AddressDeleteState) {
                        if (state.address != null) {
                          return addresses(addresses: state.address);
                        } else
                          return addresses(addresses: []);
                      }
                      return addresses(addresses: []);
                    }),
                    Divider(
                      color: cartTextColor,
                      endIndent: screenWidth * 0.05,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddAddressScreen(
                              user: widget.user,
                            )));
              },
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Material(
                  elevation: 4,
                  child: Container(
                    height: 60,
                    width: double.maxFinite,
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.location_history,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              'Add Address',
                              style: TextStyle(color: primaryColor),
                            ).tr(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<CartCubit, CartState>(builder: (context, state) {
              if (state is CartLoadedState) {
                if (state.cartItems != null && state.cartItems.length != 0) {
                  return orderPrices(state.total, state.subTotal);
                }
                return orderPrices(0.0, 0.0);
              }
              return orderPrices(0.0, 0.0);
            })
          ],
        ),
      ),
    );
  }

  Widget orderPrices(total, subTotal) {
    return Container(
      width: double.maxFinite,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            PaymentColumn(
              subTotal: subTotal.toString(),
              total: (total + widget.shipRate).toString(),
              flatShippingRate: widget.shipRate.toString(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(
                height: 65,
                width: double.maxFinite,
                child: Text('Proceed to payments',
                        style: TextStyle(fontSize: 15, color: Colors.white))
                    .tr(),
                borderColor: Colors.transparent,
                innerColor: primaryColor,
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (_) => Center(
                      child: Image.asset(
                        'assets/images/loader.gif',
                        scale: 3,
                      ),
                    ),
                  );
                  var misc = MiscRepositoryImpl();
                  ShipRate shipRate = await misc.getShipRate();
                  CODRate codRate = await misc.getCODRate();
                  if (name.text != '' && phone.text != '') {
                    CheckOutInfo checkout = CheckOutInfo(
                        address: ads,
                        city: city,
                        country: country,
                        phone: phone.text,
                        email: email.text,
                        name: name.text,
                        postal: postal,
                        addressId: addressId);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                                user: widget.user,
                                checkout: checkout,
                                codRate: codRate.charges,
                                shipRate: shipRate.shippingRate,
                                total: total,
                                subTotal: subTotal)));
                  } else
                    showToast("Please fill all fields", primaryColor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addresses({List<Address> addresses}) {
    if (addresses.length > 0) {
      List<Widget> widgets = [];
      for (int i = 0; i < addresses.length; i++) {
        if (i == 0) {
          ads = addresses[0].address;
          city = addresses[0].city;
          country = addresses[0].country;
          postal = addresses[0].postalCode;
          addressId = addresses[0].id;
          label = addresses[0].label ?? "";
        }
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            tileColor: Colors.white,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Address ${addresses[i].id}').tr(),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 22,
                      width: 60,
                      color: Color(0xFF4369D3),
                      child: Center(
                        child: Text(
                          addresses[i].label == null || addresses[i].label == ""
                              ? "Home"
                              : addresses[i].label,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ).tr(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${addresses[i].address} ${addresses[i].city}, ${addresses[i].country}.',
                  style: normalTextStyle,
                  maxLines: 3,
                )
              ],
            ),
            trailing: Radio(
              value: addresses[i].id,
              groupValue: groupValue,
              activeColor: primaryColor,
              onChanged: (val) {
                setState(() {
                  groupValue = val;
                  ads = addresses[i].address;
                  city = addresses[i].city;
                  country = addresses[i].country;
                  postal = addresses[i].postalCode;
                  addressId = addresses[i].id;
                  print(ads);
                });
              },
            ),
          ),
        ));
      }
      return Container(
        height: widgets.length == 1 ? 120 : (widgets.length == 2 ? 220 : (300)),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: widgets,
        ),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('You have no address added.').tr(),
      ),
    );
  }
}
