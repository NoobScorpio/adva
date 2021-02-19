import 'dart:convert';

import 'package:adva/bloc/address_bloc/addressCubit.dart';
import 'package:adva/bloc/address_bloc/addressState.dart';
import 'package:adva/data/model/address.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/screens/addAddressScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressScreen extends StatefulWidget {
  final User user;

  const AddressScreen({Key key, this.user}) : super(key: key);
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Addresses',
          style: TextStyle(color: Colors.black),
        ),
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: BlocConsumer<AddressCubit, AddressState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AddressLoadingState)
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: primaryColor,
                  ),
                );
              if (state is AddressLoadingState)
                return makeAddresses(addresses: []);
              if (state is AddressLoadedState) {
                if (state.address != null) {
                  return makeAddresses(addresses: state.address);
                } else
                  return makeAddresses(addresses: []);
              }
              if (state is AddressAddState) {
                if (state.address != null) {
                  return makeAddresses(addresses: state.address);
                } else
                  return makeAddresses(addresses: []);
              }
              if (state is AddressDeleteState) {
                if (state.address != null) {
                  return makeAddresses(addresses: state.address);
                } else
                  return makeAddresses(addresses: []);
              }
              return makeAddresses(addresses: []);
            },
          )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MyButton(
              height: 55,
              child: Text(
                'Add new address',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddAddressScreen(
                              user: widget.user,
                              edit: false,
                            )));
              },
              width: double.maxFinite,
              innerColor: primaryColor,
              borderColor: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }

  Widget makeAddresses({List<Address> addresses}) {
    if (addresses.length > 0) {
      List<Widget> widgets = [];
      widgets.add(SizedBox(
        height: 10,
      ));
      for (Address address in addresses) {
        widgets.add(Container(
          height: 160,
          width: double.maxFinite,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Details'),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences sp =
                                await SharedPreferences.getInstance();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddAddressScreen(
                                          user: User.fromJson(json
                                              .decode(sp.getString('user'))),
                                          edit: true,
                                          address: address,
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                                Text('Edit')
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 25,
                          color: Colors.grey,
                        ),
                        GestureDetector(
                          onTap: () async {
                            bool deleted =
                                await BlocProvider.of<AddressCubit>(context)
                                    .deleteAddress(address);
                            if (deleted)
                              showToast("Address Deleted", primaryColor);
                            else
                              showToast("Address not deleted", primaryColor);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                ),
                                Text('Remove')
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(),
                ),
                Text(
                  'Address',
                  style: boldTextStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('${address.address}'),
                ),
              ],
            ),
          ),
        ));
      }
      return ListView(
        children: widgets,
      );
    } else
      return Center(
        child: Text('No Address saved'),
      );
  }
}
