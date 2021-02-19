import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:adva/data/model/user.dart';
import 'package:adva/data/model/wishlist.dart';
import 'package:adva/res/appStrings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

abstract class UserRepository {
  Future<User> logIn({String email, String password});
  Future<User> getUser();
  Future<bool> updateUser(User user);
  Future<bool> updateUserProfile(User user, File profile);
  Future<bool> updatePass(User user, String pass, String newPass);
  Future<bool> createAccount(
      {String fName,
      String lName,
      String email,
      String phone,
      String pass,
      String cPass});
}

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl();
  @override
  Future<User> logIn({String email, String password}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
      SharedPreferences sp = await SharedPreferences.getInstance();

      var data = json.decode(response.body);
      User user = User.fromJson(data);
      sp.setString('user', json.encode(user.toJson()));
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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return User.fromJson(json.decode(sharedPreferences.getString('user')));
  }

  @override
  Future<bool> updatePass(User user, String pass, String newPass) async {
    var response = await http
        .post(baseURL + "/customer/password/update/${user.id}", body: {
      "current_password": pass,
      "password": newPass,
      "confirm_password": newPass,
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
  Future<bool> updateUser(User user) async {
    // print("createAccount : INSIDE $email and $pass");
    var response =
        await http.post(baseURL + "/customer/update/${user.id}", body: {
      "email": user.email,
      "first_name": user.firstName,
      "last_name": user.lastName,
      "phone": user.phone,
      "token": user.token,
      "points": user.points,
      "profile_image": user.profileImage,
      "name": user.name,
      "id": user.id,
    });
    // print("createAccount : ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('user', json.encode(user.toJson()));
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
  Future<bool> updateUserProfile(User user, File profile) async {
    try {
      // var request = http.MultipartRequest(
      //   'POST',
      //   Uri.parse(baseURL + "/customer/profile/update/${user.id}"),
      // );
      // Map<String, String> headers = {"Content-type": "multipart/form-data"};
      // request.headers.addAll(headers);
      //
      // request.files.add(
      //   http.MultipartFile(
      //     'file',
      //     profile.readAsBytes().asStream(),
      //     profile.lengthSync(),
      //     filename: profile.path.split("/").last,
      //     contentType: MediaType('image', 'jpeg'),
      //   ),
      // );
      // var response = await request.send();
      var response = await http.post(
          baseURL + "/customer/profile/update/${user.id}",
          body: {"profile_image": base64Encode(await profile.readAsBytes())});
      print("IMAGE RESPONSE ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        // SharedPreferences sp=await SharedPreferences.getInstance();
        // var data=json.decode(response.);
        print("IMAGE RESPONSE ${response.statusCode}");

        return true;
      } else if (response.statusCode == 400) {
        print("IMAGE RESPONSE ${response.statusCode}");
        // response.stream.transform(utf8.decoder).listen((value) {
        //   print(value);
        // });
        print('This data does not exist.');
        return false;
      } else if (response.statusCode == 500) {
        print("IMAGE RESPONSE ${response.statusCode}");
        // response.stream.transform(utf8.decoder).listen((value) {
        //   print(value);
        // });
        print('Internal server error.');
        return false;
      } else {
        print("IMAGE RESPONSE ${response.statusCode}");
        // response.stream.transform(utf8.decoder).listen((value) {
        //   print(value);
        // });
        print('Something went wrong');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
