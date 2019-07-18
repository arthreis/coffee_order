import 'package:coffee_order/models/order_item.dart';
import 'package:coffee_order/models/product.dart';
import 'package:coffee_order/util/string_utils.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final Function callback;
  final orderItem = OrderItem(quantity: 0, subtotal: 0);

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
            leading: Image.asset(_getFullImagePath(widget.product.name) ??
                'assets/images/coffee_icons/empty.png'),
            title: Text(widget.product.name),
            subtitle: Text(StringUtils.formatPrice(widget.product.price)),
          ),
          Text(
            '${widget.orderItem.quantity}',
            style: Theme.of(context).textTheme.display1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(StringUtils.formatPrice(widget.orderItem.subtotal)),
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
                        textTheme: ButtonTextTheme.accent),
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
      widget.orderItem.quantity++;
      widget.orderItem.subtotal = widget.orderItem.quantity * widget.product.price;
    });

    widget.callback(widget.product.price);
  }

  void _removeProduct() {
    if (widget.orderItem.quantity > 0) {
      setState(() {
        widget.orderItem.quantity--;
        widget.orderItem.subtotal = widget.orderItem.quantity * widget.product.price;
      });

      widget.callback(-widget.product.price);
    }
  }
}

_getFullImagePath(String productName) {
  const String PATH_PREFIX = 'assets/images/coffee_icons/';
  final String imageName =
      productName.split(' ').map((name) => name.toLowerCase()).join('-') +
          '.webp';
  return PATH_PREFIX + imageName;
}
