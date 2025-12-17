import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amazon_clone/constants/global_variables.dart';

class AuthService {
  //sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: "",
        name: name,
        email: email,
        address: "",
        type: "",
        password: password,
        token: "",
      );

      http.Response res = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandel(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            "Account created!,Login with the same credentials",
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandel(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await pref.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, "Error : ${e.toString()}");
    }
  }

  //GET USER DATA
  void getUserData(BuildContext context) async {
    try {
      //get the token from shared preferences
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString(
        'x-auth-token',
      ); // ? - because it can be null if user is logged out or using app for first time

      if (token == null) {
        pref.setString('x-auth-token', '');
      }

      //Validate the token

      http.Response tokenRes = await http.post(
        Uri.parse("$uri/api/isTokenValid"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": token!,
        },
      );

      //tokenRes will be either be true(valid) or false(invalid)
      var response = jsonDecode(tokenRes.body);

      //if token is valid
      if (response == true) {
        //get user data
        http.Response userRes = await http.get(
          Uri.parse("$uri/"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token,
          },
        );
        Provider.of<UserProvider>(context, listen: false).setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, "Error : ${e.toString()}");
    }
  }

  //We will resolve the warning for the use of BuildContext across async gap later on.
}
