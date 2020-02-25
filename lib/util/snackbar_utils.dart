import 'package:flutter/material.dart';

class SnackBarUtils {
  static void showSnackBar(context, message, success) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: success ? Colors.lightGreen : Colors.redAccent,
      duration: Duration(seconds: 4),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
