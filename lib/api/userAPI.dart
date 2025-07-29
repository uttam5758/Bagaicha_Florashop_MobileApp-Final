import 'package:cybershop/response/loginResponse.dart';
import 'package:flutter/material.dart';
import 'package:cybershop/api/httpservices.dart';
import 'package:cybershop/models/userModel.dart';
import 'package:cybershop/util/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAPI {
  Future<bool> registerUser(User user) async {
    bool isLogin = false;
    Response response;
    var url = baseUrl + registerUrl;

    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.post(
        url,
        data: user.toJson(),
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isLogin;
  }

  Future<bool> loginUser(User user) async {
    bool isLogin = false;
    Response response;
    var url = baseUrl + loginUrl;

    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.post(
        url,
        data: user.toJson(),
      );
      if (response.statusCode == 201) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        String email = (response.data['user']['email']);
        token = loginResponse.token;
        print(loginResponse.token);
        SharedPreferences preferences;

        preferences = await SharedPreferences.getInstance();
        preferences.setString("email", '$email');
        preferences.setString("token", '$token');

        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isLogin;
  }

  //change password
  Future<bool> changePassword(
      String? oldPassword, String? newPassword, String? passwordConfirm) async {
    bool changePassword = false;
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? passwordtoken = sharedPreferences.getString("token");
    const passwordtoken = Token;
    Response response;
    var url = baseUrl + changePasswordUrl;

    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.put(
        url,
        data: {
          "oldPassword": oldPassword,
          "newPassword": newPassword,
          "passwordConfirm": passwordConfirm,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $passwordtoken",
          },
        ),
      );
      if (response.statusCode == 200) {
        changePassword = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return changePassword;
  }

  // changeProfile
  Future<bool> updateProfile(
    String? name,
    String? email,
  ) async {
    bool updateUserProfile = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? passwordtoken = sharedPreferences.getString("token");
    Response response;
    var url = baseUrl + updateProfileUrl;

    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.put(
        url,
        data: {
          "name": name,
          "email": email,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $passwordtoken",
          },
        ),
      );
      if (response.statusCode == 200) {
        updateUserProfile = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return updateUserProfile;
  }
}
