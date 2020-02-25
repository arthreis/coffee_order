import 'package:flutter/material.dart';

class SnackBarUtils {
  static void showSnackBar(context, message, success) {
    final snackBar = SnackBar(
      content: Text(message, style: Theme.of(context).accentTextTheme.body2),
      backgroundColor: success ? Color(0xff03DAC6) : Color(0xffCF6679),
      duration: Duration(seconds: 4),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
