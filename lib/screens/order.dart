import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Pedido"),
      ),
      body: Center(
        child: ListView(children: <Widget>[
          Card(child: Text("Quack")),
          Card(child: Text("Quack"))
        ])
      )
    );
  }
}