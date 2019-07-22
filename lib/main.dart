import 'dart:convert';

import 'package:coffee_order/screens/home.dart';
import 'package:coffee_order/screens/products/products.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Future<String> userName;

  @override
  void initState() {
    super.initState();
    userName = _getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Order',
      theme: ThemeData(primarySwatch: Colors.amber, brightness: Brightness.dark, accentColor: Colors.amberAccent),
      home: FutureBuilder(
          future: userName,
          builder: (context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return snapshot.data != null
                    ? ProductsPage(userName: snapshot.data)
                    : MyHomePage();
              default:
                return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<String> _getUserName() {
    return SharedPreferences.getInstance().then((preferences) {
      return User.fromJson(json.decode(preferences.getString('user'))).name;
    }).catchError((error) {
      return error;
    });
  }
}
