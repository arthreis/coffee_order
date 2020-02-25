import 'package:coffee_order/model/product_model.dart';
import 'package:coffee_order/util/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final int index;

  ProductCard(this.index, {Key key}) : super(key: key);

  @override
  Widget build(context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      color: Theme.of(context).cardColor,
      child: Consumer<ProductModel>(
        builder: (context, productModel, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 25, 0),
                leading: FutureProvider<Widget>(
                  create: (context) =>
                      _loadProductThumbnail(productModel.products[index].name),
                  initialData: Icon(Icons.image),
                  child: Consumer<Widget>(
                      builder: (context, widget, child) => widget),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      productModel.products[index].name,
                    )
                  ],
                ),
                subtitle: Text(StringUtils.formatPrice(
                    productModel.products[index].price)),
                trailing: Text(
                  '${productModel.orders[index].quantity}',
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(23, 0, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      StringUtils.formatPrice(
                          productModel.orders[index].subtotal),
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.remove,),
                          onPressed: productModel.orders[index].quantity > 0
                              ? () => productModel.removeProduct(index)
                              : null,
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.add),
                          onPressed: () => productModel.addProduct(index),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

String _getFullImagePath(String productName) {
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
//    return Image.memory(imageData.buffer.asUint8List());
    return SizedBox(
        child: Center(child: Image.memory(imageData.buffer.asUint8List())),
        width: 60,
        height: 60);
  } catch (e) {
    print(e.toString());
    return SizedBox(
        child: Center(child: Icon(Icons.broken_image)), width: 60, height: 60);
  }
}
