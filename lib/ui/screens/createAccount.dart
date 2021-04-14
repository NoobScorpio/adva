import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/data/repository/userRepo.dart';
import 'package:adva/ui/screens/accountsloginScreen.dart';
import 'package:adva/ui/screens/verifyEmailScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String fName = '', lName = '', email = '', pass = '', phone = '', cPass = '';
  String code = "966";

  bool passH = true, cPassH = true;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        // toolbarHeight: screenHeight * 0.09,
        title: Text(
          'Accounts'.tr(),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.06),
                        child: Text(
                          'Create Account',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ).tr(),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'First Name'.tr(),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        onChanged: (val) {
                          fName = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Last Name'.tr(),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        onChanged: (val) {
                          lName = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Email'.tr(),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                    ),
                    if (context.locale == Locale('en', ''))
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 65,
                            decoration: BoxDecoration(
                              // color: Colors.white.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                color: Colors.grey, // red as border color
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                  exclude: <String>['KN', 'MF'],
                                  //Optional. Shows phone code before the country name.
                                  showPhoneCode: true,
                                  onSelect: (Country country) {
                                    print(
                                        'Select country: ${country.displayName} ');
                                    setState(() {
                                      code = country.phoneCode;
                                      print("@CODE $code");
                                    });
                                  },
                                );
                              },
                              child: Container(
                                  width: 50,
                                  height: 25,
                                  color: Colors.grey[50],
                                  child: Center(
                                      child: Text(
                                    "+$code",
                                    style: TextStyle(color: primaryColor),
                                  ))),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // width: MediaQuery.of(context).size.width,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Phone Number".tr() +
                                      ' ( 5x xxx xxxx )'.tr(),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                ),
                                onChanged: (val) {
                                  phone = val;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (!(context.locale == Locale('en', '')))
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              // width: MediaQuery.of(context).size.width,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Phone Number".tr() +
                                      ' ( 5x xxx xxxx )'.tr(),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                ),
                                onChanged: (val) {
                                  phone = val;
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 65,
                            decoration: BoxDecoration(
                              // color: Colors.white.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                color: Colors.grey, // red as border color
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                  exclude: <String>['KN', 'MF'],
                                  //Optional. Shows phone code before the country name.
                                  showPhoneCode: true,
                                  onSelect: (Country country) {
                                    print(
                                        'Select country: ${country.displayName} ');
                                    setState(() {
                                      code = country.phoneCode;
                                      print("@CODE $code");
                                    });
                                  },
                                );
                              },
                              child: Container(
                                  width: 50,
                                  height: 25,
                                  color: Colors.grey[50],
                                  child: Center(
                                      child: Text(
                                    "$code+",
                                    style: TextStyle(color: primaryColor),
                                  ))),
                            ),
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        height: 60,
                        child: TextField(
                          obscureText: passH,
                          decoration: InputDecoration(
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  passH = !passH;
                                });
                              },
                              icon: Icon(Icons.remove_red_eye),
                            ),
                            hintText: 'Password'.tr(),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                          onChanged: (val) {
                            pass = val;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        height: 60,
                        child: TextField(
                          obscureText: cPassH,
                          decoration: InputDecoration(
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  cPassH = !cPassH;
                                });
                              },
                              icon: Icon(Icons.remove_red_eye),
                            ),
                            hintText: 'Confirm Password'.tr(),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                          onChanged: (val) {
                            cPass = val;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: MyButton(
                    height: 60,
                    borderColor: Colors.transparent,
                    innerColor: primaryColor,
                    width: screenWidth,
                    child: Text(
                      'CREATE',
                      style: TextStyle(color: Colors.white),
                    ).tr(),
                    onPressed: () async {
                      showToast('Creating Account', primaryColor);
                      if (pass == cPass) {
                        if (fName == '' ||
                            lName == "" ||
                            pass == '' ||
                            cPass == '' ||
                            phone == '') {
                          showToast("Please fill all fields", primaryColor);
                        } else {
                          if (phone[0] == '0') {
                            phone = phone.substring(1, phone.length);
                            phone = code + phone;
                            print("@PHONEb $phone");
                          } else if (phone.contains(code)) {
                            print("@PHONEb $phone");
                          } else {
                            phone = code + phone;
                            print("@PHONEb $phone");
                          }

                          int created = await UserRepositoryImpl()
                              .createAccount(
                                  email: email ?? "",
                                  pass: pass,
                                  cPass: cPass,
                                  phone: phone,
                                  fName: fName,
                                  lName: lName);
                          if (created != null) {
                            showToast(
                                'User created successfully', primaryColor);
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => VerifyEmailScreen(
                                        register: true, id: created)));
                            Navigator.pop(context);
                          } else {
                            showToast('Please try again later', primaryColor);
                          }
                        }
                      } else {
                        showToast("Passwords do not match", primaryColor);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Or',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ).tr(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: MyButton(
                    height: 60,
                    borderColor: Colors.transparent,
                    innerColor: primaryColor,
                    width: screenWidth,
                    child: Text(
                      'VERIFY',
                      style: TextStyle(color: Colors.white),
                    ).tr(),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => VerifyEmailScreen(
                                  register: false, id: null)));
                    },
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountsLoginScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ).tr(),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Log In',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                        ),
                      ).tr(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
