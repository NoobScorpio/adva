// import 'package:adva/screens/accountsloginScreen.dart';
// import 'package:adva/utils/constants.dart';
// import 'package:adva/utils/primaryButton.dart';
// import 'package:flutter/material.dart';

// class CreateAccountScreen extends StatefulWidget {
//   @override
//   _CreateAccountScreenState createState() => _CreateAccountScreenState();
// }

// class _CreateAccountScreenState extends State<CreateAccountScreen> {
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         toolbarHeight: screenHeight * 0.09,
//         title: Center(
//             child: Padding(
//           padding: EdgeInsets.only(top: screenHeight * 0.026),
//           child: Text(
//             'Accounts',
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
//           ),
//         )),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
//         child: Column(
//           children: [
//             SizedBox(
//               height: screenHeight * 0.08,
//             ),
//             Center(
//               child: Text(
//                 'Create Account',
//                 style: TextStyle(color: Colors.black, fontSize: 16),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                   top: screenHeight * 0.01, bottom: screenHeight * 0.05),
//               child: Divider(
//                 thickness: 0.5,
//                 color: cartTextColor,
//               ),
//             ),
//             HTFContainer(
//               screenHeight: screenHeight,
//               hintT: 'Name',
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: screenHeight * 0.012),
//               child: HTFContainer(
//                 screenHeight: screenHeight,
//                 hintT: 'Email',
//               ),
//             ),
//             HTFContainer(
//               screenHeight: screenHeight,
//               hintT: 'Phone no.',
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                 top: screenHeight * 0.03,
//               ),
//               child: PrimaryButton(
//                 screenHeight: screenHeight,
//                 screenWidth: screenWidth,
//                 txt: 'CREATE',
//                 onpressed: () {},
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.23),
//             Text('Already have an account'),
//             Text(
//               'Log in',
//               style: TextStyle(
//                 color: primaryColor,
//                 fontSize: 16,
//                 decoration: TextDecoration.underline,
//                 decorationColor: Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
