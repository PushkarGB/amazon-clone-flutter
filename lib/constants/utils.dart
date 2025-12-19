import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void showSnackBar(String text){
  scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text(text)));
}