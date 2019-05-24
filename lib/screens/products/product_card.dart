import 'package:coffee_order/models/product.dart';
import 'package:flutter/material.dart';
import '../../util/string_utils.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final Function callback;
  int _quantity = 0;
  double _subtotal = 0;

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
            '${widget._quantity}',
            style: Theme.of(context).textTheme.display1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(StringUtils.formatPrice(widget._subtotal)),
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
      widget._quantity++;
      widget._subtotal = widget._quantity * widget.product.price;
    });

    widget.callback(widget.product.price);
  }

  void _removeProduct() {
    if (widget._quantity > 0) {
      setState(() {
        widget._quantity--;
        widget._subtotal = widget._quantity * widget.product.price;
      });

      widget.callback(-widget.product.price);
    }
  }
}
