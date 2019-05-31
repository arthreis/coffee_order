import 'package:coffee_order/screens/products/products.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}): super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _nameFieldController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Bem vindo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameFieldController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Usuário',
              ),
            ),
            RaisedButton(
              child: Text(
                'Avançar',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () async {
                final preferences = await SharedPreferences.getInstance();
                if (_nameFieldController.text.isNotEmpty) {
                  await preferences.setString('user', _nameFieldController.text);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductsPage(userName: _nameFieldController.text)));
                } else {
                  SnackBar mensagemErro = SnackBar(content: Text('Nome vazio!'), backgroundColor: Colors.redAccent, duration: Duration(seconds: 4),);
                  _scaffoldKey.currentState.showSnackBar(mensagemErro);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _nameFieldController.dispose();
    super.dispose();
  }
}
