import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/ui/screens/bottomNavBar.dart';
import 'package:adva/ui/screens/userScreen.dart';
import 'package:adva/ui/utils/constants.dart';
import 'package:adva/ui/utils/myButton.dart';
import 'package:adva/ui/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String fName = '', lName = '', email = '', pass = '', phone = '', cPass = '';
  bool passH = true, cPassH = true;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        // toolbarHeight: screenHeight * 0.09,
        title: Text(
          'Accounts',
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
                        ),
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
                          hintText: 'First Name',
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
                          hintText: 'Last Name',
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
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        onChanged: (val) {
                          phone = val;
                        },
                      ),
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
                            hintText: 'Password',
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
                            hintText: 'Confirm Password',
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
                    ),
                    onPressed: () async {
                      if (pass == cPass) {
                        if (fName == '' ||
                            lName == "" ||
                            email == '' ||
                            pass == '' ||
                            cPass == '' ||
                            phone == '') {
                          showToast("Please fill all fields", primaryColor);
                        } else {
                          bool created =
                              await BlocProvider.of<UserLogInCubit>(context)
                                  .createUser(
                                      email, pass, cPass, phone, fName, lName);
                          if (created) {
                            showToast(
                                'User created successfully', primaryColor);
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
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
                      ),
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
                      ),
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
