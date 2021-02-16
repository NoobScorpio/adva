import 'package:adva/bloc/user_bloc/userState.dart';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/repository/userRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLogInCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  final bool initial;
  final User user;
  UserLogInCubit({this.user, this.initial, this.userRepository})
      : super(UserInitialState(loggedIn: initial, user: user));

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

  Future<bool> createUser(String email, String pass, String cPass, String phone,
      String fName, String lName) async {
    try {
      emit(UserLoadingState());
      bool user = await userRepository.createAccount(
          email: email,
          pass: pass,
          cPass: cPass,
          phone: phone,
          fName: fName,
          lName: lName);
      emit(UserCreatedState(created: user));
      setStatus(false);
      if (user)
        return true;
      else
        return false;
    } on Exception {
      emit(UserErrorState(message: "Could not get user"));
      return false;
    }
  }

  Future<void> setStatus(bool status) async {
    emit(UserLoggedInState(status));
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
