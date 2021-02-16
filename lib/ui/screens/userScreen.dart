import 'package:adva/bloc/user_bloc/userLogInCubit.dart';
import 'package:adva/bloc/user_bloc/userState.dart';
import 'package:adva/ui/screens/accountScreen.dart';
import 'package:adva/ui/screens/accountsloginScreen.dart';
import 'package:adva/ui/utils/statesUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLogInCubit, UserState>(listener: (context, state) {
      if (state is UserLoggedInState)
        BlocProvider.of<UserLogInCubit>(context).setStatus(state.loggedIn);
    }, builder: (context, state) {
      print(state);
      if (state is UserInitialState) {
        if (state.user == null) {
          print("UserInitialState: ${state.loggedIn}");
          return AccountsLoginScreen();
        } else
          return AccountScreen();
      } else if (state is UserLoadingState)
        return buildLoading();
      else if (state is UserLoadedState) {
        if (state.user != null)
          return AccountScreen();
        else
          return AccountsLoginScreen();
      } else if (state is UserLoggedInState) {
        print("INSIDE UserLoggedInState ${state.loggedIn}");
        if (state.loggedIn) {
          print("INSIDE UserLoggedInState true");
          return AccountScreen();
        } else
          return AccountsLoginScreen();
      } else {
        return AccountsLoginScreen();
      }
    });
  }
}
