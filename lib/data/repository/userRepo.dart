import 'dart:async';
import 'dart:convert';
import 'package:adva/data/model/user.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRepository {
  Future<User> logIn({String email, String password});
  Future<User> getUser();
  Future<bool> createAccount(
      {String fName,
      String lName,
      String email,
      String phone,
      String pass,
      String cPass});
}

class UserRepositoryImpl implements UserRepository {
  final SharedPreferences sharedPreferences;

  UserRepositoryImpl(this.sharedPreferences);
  @override
  Future<User> logIn({String email, String password}) async {
    print("LOGIN : INSIDE $email and $password");
    var response = await http.post(baseURL + "/customers/login",
        body: {"email": email, "password": password});
    print("LOGIN : ${response.body}");
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        User user = User.fromJson(data);
        sharedPreferences.setString('user', json.encode(user.toJson()));
        return user;
      } catch (e) {
        return null;
      }
    } else if (response.statusCode == 400) {
      print('This data does not exist.');
      return null;
    } else if (response.statusCode == 500) {
      print('Internal server error.');
      return null;
    } else {
      print('Something went wrong');
      return null;
    }
  }

  @override
  Future<bool> createAccount(
      {String fName,
      String lName,
      String email,
      String phone,
      String pass,
      String cPass}) async {
    print("createAccount : INSIDE $email and $pass");
    var response = await http.post(baseURL + "/customer/create", body: {
      "email": email,
      "password": pass,
      "first_name": fName,
      "last_name": lName,
      "phone": phone,
      "confirm_password": cPass,
    });
    print("createAccount : ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 400) {
      print('This data does not exist.');
      return false;
    } else if (response.statusCode == 500) {
      print('Internal server error.');
      return false;
    } else {
      print('Something went wrong');
      return false;
    }
  }

  @override
  Future<User> getUser() async {
    return json.decode(sharedPreferences.getString('user'));
  }
}
