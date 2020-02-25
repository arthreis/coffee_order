import 'package:coffee_order/model/product_model.dart';
import 'package:coffee_order/util/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final int index;

  ProductCard(this.index, {Key key}) : super(key: key);

  @override
  Widget build(context) {
    return Card(
      child: Consumer<ProductModel>(
        builder: (context, productModel, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: FutureProvider<Widget>(
                  create: (context) => _loadProductThumbnail(
                      productModel.products[index].name),
                  initialData: Icon(Icons.image),
                  child: Consumer<Widget>(
                      builder: (context, widget, child) => widget),
                ),
                title: Text(productModel.products[index].name),
                subtitle: Text(StringUtils.formatPrice(
                    productModel.products[index].price)),
              ),
              Text(
                '${productModel.orders[index].quantity}',
                style: Theme.of(context).textTheme.display1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(StringUtils.formatPrice(
                      productModel.orders[index].subtotal)),
                  ButtonBarTheme(
                    data: ButtonBarThemeData(),
                    child: ButtonBar(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () =>
                              productModel.addProduct(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () =>
                              productModel.removeProduct(index),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

_getFullImagePath(String productName) {
  const String PATH_PREFIX = 'assets/images/coffee_icons/';
  final String imageName =
      productName.split(' ').map((name) => name.toLowerCase()).join('-') +
          '.webp';
  return PATH_PREFIX + imageName;
}

Future<Widget> _loadProductThumbnail(String productName) async {
  final String imagePath = _getFullImagePath(productName);
  try {
    print(imagePath);
    final imageData = await rootBundle.load(imagePath);
    return Image.memory(imageData.buffer.asUint8List());
  } catch (e) {
    print(e.toString());
    return Icon(Icons.broken_image);
  }
}
