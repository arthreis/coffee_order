import 'package:flutter/material.dart';

class SnackBarUtils {
  static void showSnackBar(context, message, success) {
    final theme = Theme.of(context);
    final snackBar = SnackBar(
      content: Text(message, style: theme.accentTextTheme.body2),
      backgroundColor: success ? theme.indicatorColor : theme.errorColor,
      duration: Duration(seconds: 4),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
