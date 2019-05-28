import 'package:coffee_order/models/order.dart';
import 'package:coffee_order/models/product.dart';
import 'package:coffee_order/util/string_utils.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final Function callback;
  final order = Order(quantity: 0, subtotal: 0);

  ProductCard({@required this.product, @required this.callback, Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  @override
  Widget build(context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image.asset(widget.product.imagePath ??
                'assets/images/coffee_icons/empty.png'),
            title: Text(widget.product.name),
            subtitle: Text(StringUtils.formatPrice(widget.product.price)),
          ),
          Text(
            '${widget.order.quantity}',
            style: Theme.of(context).textTheme.display1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(StringUtils.formatPrice(widget.order.subtotal)),
              ButtonTheme.bar(
                // make buttons use the appropriate styles for cards
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton.icon(
                      onPressed: _addProduct,
                      icon: Icon(Icons.expand_less),
                      label: Text('ADD'),
                      textTheme: ButtonTextTheme.accent,
                    ),
                    FlatButton.icon(
                      onPressed: _removeProduct,
                      icon: Icon(Icons.expand_more),
                      label: Text('REMOVE'),
                      textTheme: ButtonTextTheme.accent
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
      widget.order.quantity++;
      widget.order.subtotal = widget.order.quantity * widget.product.price;
    });

    widget.callback(widget.product.price);
  }

  void _removeProduct() {
    if (widget.order.quantity > 0) {
      setState(() {
        widget.order.quantity--;
        widget.order.subtotal = widget.order.quantity * widget.product.price;
      });

      widget.callback(-widget.product.price);
    }
  }
}
