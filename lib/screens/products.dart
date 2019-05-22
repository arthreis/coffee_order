import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  @override
  ProductsPageState createState() {
    return ProductsPageState();
  }
}

class ProductsPageState extends State<ProductsPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Total Pedido"),
        ),
        body: ListView(children: <Widget>[
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,              
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.album),
                  title: Text('Ristretto'),
                  subtitle: Text('R\$ 2,05'),
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.display1,
                ),
                ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton.icon(
                        onPressed: _addProduct,
                        icon: Icon(Icons.expand_less),
                        label: Text('ADD'),
                      ),
                      FlatButton.icon(
                        onPressed: _removeProduct,
                        icon: Icon(Icons.expand_more),
                        label: Text('REMOVE'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  void _addProduct() {
    setState(() {
      _counter++;
    });
  }

  void _removeProduct() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }
}
