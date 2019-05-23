import 'package:coffee_order/models/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard({@required this.product, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  int _quantity = 0;
  double _subtotal = 0;

  @override
  Widget build(context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text(widget.product.name),
            subtitle: Text(widget.product.price.toString()),
          ),
          Text(
            '$_quantity',
            style: Theme.of(context).textTheme.display1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('R\$ $_subtotal'),
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
        ],
      ),
    );
  }

  void _addProduct() {
    setState(() {
      _quantity++;
      _subtotal = _quantity * widget.product.price;
    });
  }

  void _removeProduct() {
    setState(() {
      if (_quantity > 0) {
        _quantity--;
        _subtotal = _quantity * widget.product.price;
      }
    });
  }
}
