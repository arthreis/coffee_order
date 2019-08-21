import 'dart:convert';

import 'package:coffee_order/api/api.dart';
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
  Future<User> userId;

  @override
  void initState() {
    super.initState();
    userId = _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Order',
      theme: ThemeData(primarySwatch: Colors.amber, brightness: Brightness.dark, accentColor: Colors.amberAccent),
      home: FutureBuilder(
          future: userId,
          builder: (context, AsyncSnapshot<User> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return snapshot.data != null
                    ? ProductsPage(userName: snapshot.data.name)
                    : MyHomePage();
              default:
                return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<User> _getUser() async {
    var preferences = await SharedPreferences.getInstance();
    return Api().getUserById(preferences.getString('userId'));
  }
}
