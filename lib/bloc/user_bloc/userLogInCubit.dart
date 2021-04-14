import 'dart:io';

import 'package:adva/bloc/user_bloc/userState.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/repository/userRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  // final bool initial;
  // final User user;
  UserCubit({this.userRepository}) : super(UserInitialState());

  Future<bool> loginUser(String email, String pass) async {
    try {
      emit(UserLoadingState());
      User user = await userRepository.logIn(email: email, password: pass);
      emit(UserLoadedState(user: user));
      if (user == null)
        return false;
      else
        return true;
    } on Exception {
      emit(UserErrorState(message: "Could not get user"));
      return false;
    }
  }

  Future<int> createUser(String email, String pass, String cPass, String phone,
      String fName, String lName) async {
    try {
      emit(UserLoadingState());
      int user = await userRepository.createAccount(
          email: email,
          pass: pass,
          cPass: cPass,
          phone: phone,
          fName: fName,
          lName: lName);
      if (user != null)
        emit(UserCreatedState(created: true));
      else
        emit(UserCreatedState(created: false));
      setStatus(false);
      print("@USER STATE RETURN $user");
      return user;
    } on Exception {
      emit(UserErrorState(message: "Could not get user"));
      return null;
    }
  }

  Future<void> setStatus(bool status) async {
    emit(UserLoggedInState(status));
  }

  Future<User> getUser() async {
    try {
      // emit(UserLoadingState());
      User user = await userRepository.getUser();

      if (user == null)
        return User();
      else {
        emit(GetUserLoggedInState(user: user));
        return user;
      }
    } on Exception {
      emit(UserErrorState(message: "Could not get user"));
      return User();
    }
  }

  Future<bool> updateLocalInfo(User user) async {
    try {
      emit(UserLoadingState());
      bool updated = await userRepository.updateLocalUser(user);

      if (updated) {
        emit(UserLoadedState(user: user));
        return true;
      } else
        return false;
    } on Exception {
      emit(UserErrorState(message: "Could not get user"));
      return false;
    }
  }

  Future<bool> updateInfo(User user) async {
    try {
      emit(UserLoadingState());
      bool updated = await userRepository.updateUser(user);

      if (updated) {
        emit(UserLoadedState(user: user));
        return true;
      } else
        return false;
    } on Exception {
      emit(UserErrorState(message: "Could not get user"));
      return false;
    }
  }

  Future<bool> updatePass(User user, String pass, String newPass) async {
    try {
      emit(UserLoadingState());
      bool updated = await userRepository.updatePass(user, pass, newPass);
      emit(UserLoadedState(user: user));
      if (updated)
        return false;
      else
        return true;
    } on Exception {
      emit(UserErrorState(message: "Could not get user"));
      return false;
    }
  }

  Future<User> updateProfile(User user, File image) async {
    try {
      emit(UserLoadingState());
      User updated = await userRepository.updateUserProfile(user, image);

      if (user != null) {
        emit(UserLoadedState(user: updated));
        return user;
      } else
        return null;
    } on Exception {
      emit(UserErrorState(message: "Could not get user"));
      return null;
    }
  }

  logOut() {
    try {
      emit(UserLoadingState());
      emit(UserLoadedState(user: null));
    } on Exception {
      emit(UserErrorState(message: "Could not get user"));
    }
  }
}
