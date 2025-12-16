import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
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
          showSnackBar(context,"Account created!,Login with the same credentials");
        }
        );
    } catch (e) {
      showSnackBar(context,e.toString());
    }
  }

  //We will resolve the warning for the use of BuildContext across async gap later on.
}
