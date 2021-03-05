import 'dart:async';

import 'package:adva/bloc/address_bloc/addressCubit.dart';
import 'package:adva/data/model/address.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/ui/screens/confirmAddressScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class AddAddressScreen extends StatefulWidget {
  final User user;
  final Address address;
  final bool edit;

  const AddAddressScreen({Key key, this.user, this.address, this.edit})
      : super(key: key);
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController adCont, cityCont, countCont, postalCont;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adCont = TextEditingController();
    cityCont = TextEditingController();
    countCont = TextEditingController();
    postalCont = TextEditingController();
    if (widget.edit != null && widget.edit != false) {
      adCont.text = widget.address.address;
      cityCont.text = widget.address.city;
      countCont.text = widget.address.country;
      postalCont.text = widget.address.postalCode;
      address = adCont.text;
      country = cityCont.text;
      city = countCont.text;
      postal = postalCont.text;
    }
  }

  String address = '', country = '', city = '', postal = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    adCont.dispose();
    cityCont.dispose();
    countCont.dispose();
    postalCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '${widget.edit == null || widget.edit == false ? "Add" : "Edit"} address',
            style: TextStyle(color: Colors.black),
          ).tr(),
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
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Address',
                  style: normalTextStyle,
                ).tr(),
              ),
              TextField(
                controller: adCont,
                decoration: InputDecoration(
                  hintText: 'Enter full address'.tr(),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                onChanged: (val) {
                  address = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'City',
                  style: normalTextStyle,
                ).tr(),
              ),
              TextField(
                controller: cityCont,
                decoration: InputDecoration(
                  hintText: 'Enter city name'.tr(),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                onChanged: (val) {
                  city = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Country',
                  style: normalTextStyle,
                ).tr(),
              ),
              TextField(
                controller: countCont,
                decoration: InputDecoration(
                  hintText: 'Enter country name'.tr(),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                onChanged: (val) {
                  country = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Postal Code',
                  style: normalTextStyle,
                ).tr(),
              ),
              TextField(
                controller: postalCont,
                decoration: InputDecoration(
                  hintText: 'Enter postal code'.tr(),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                onChanged: (val) {
                  postal = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: MyButton(
                  height: 55,
                  innerColor: primaryColor,
                  borderColor: Colors.transparent,
                  onPressed: () async {
                    if (postal != '' &&
                        city != '' &&
                        country != "" &&
                        address != '') {
                      Address addressObj = Address();
                      addressObj.address =
                          address == '' ? widget.address.address : address;
                      addressObj.city = city == '' ? widget.address.city : city;
                      addressObj.country =
                          country == '' ? widget.address.country : country;
                      addressObj.postalCode =
                          postal == '' ? widget.address.postalCode : postal;
                      addressObj.customerId = widget.user.id;
                      if (widget.edit != null && widget.edit != false) {
                        addressObj.id = widget.address.id;
                      }
                      if (widget.edit != null && widget.edit != false) {
                        print('INSIDE EDIT ADDRESS');
                        bool updated =
                            await BlocProvider.of<AddressCubit>(context)
                                .updateAddress(addressObj);
                        if (updated) {
                          showToast("Address Updated", primaryColor);
                          Navigator.pop(context);
                        } else {
                          showToast("Address not updated", primaryColor);
                        }
                      } else {
                        bool added =
                            await BlocProvider.of<AddressCubit>(context)
                                .addAddress(addressObj);
                        if (added) {
                          showToast("Address Added", primaryColor);
                          Navigator.pop(context);
                        } else {
                          showToast("Address not added", primaryColor);
                        }
                      }
                    } else {
                      showToast("Please fill all fields", primaryColor);
                    }
                  },
                  child: Text(
                    '${widget.edit == null || widget.edit == false ? "Add" : "Edit"} Address',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ).tr(),
                ),
              )
            ],
          ),
        ));
  }

  Widget old() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kLake,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MyButton(
              height: 55,
              width: double.maxFinite,
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConfirmAddressScreen()));
                Navigator.pop(context);
                // Navigator.pop(context);
              },
              innerColor: primaryColor,
              borderColor: Colors.transparent,
              child: Text(
                'Confirm Location',
                style: TextStyle(color: Colors.white),
              ).tr(),
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton(
          onPressed: _goToTheLake,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.location_pin,
            color: primaryColor,
          ),
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
