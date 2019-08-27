import 'dart:convert';

import 'package:coffee_order/api/api.dart';
import 'package:coffee_order/models/user.dart';
import 'package:coffee_order/screens/products/products.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _nameFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Bem vindo'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _nameFieldController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                ),
              ),
              TextField(
                controller: _emailFieldController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Email"),
              ),
              MaterialButton(
                child: Text(
                  'Avançar',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: _login,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    final preferences = await SharedPreferences.getInstance();
    if (_nameFieldController.text.isNotEmpty &&
        _emailFieldController.text.isNotEmpty) {
      User user;
      try {
        user = await Api().getUserByEmail(_emailFieldController.text);
      } catch(Exception) {
        user = await Api().createUser(User(name: _nameFieldController.text, email: _emailFieldController.text));
      } finally {
        await preferences.setString('userJson', json.encode(user.toJson()));
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ProductsPage(userName: user.name)));
      }
    } else {
      SnackBar mensagemErro = SnackBar(
        content: Text('Nome ou email não preenchido!'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 4),
      );
      _scaffoldKey.currentState.showSnackBar(mensagemErro);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _nameFieldController.dispose();
    _emailFieldController.dispose();
    super.dispose();
  }
}
