import 'dart:developer';

import 'package:coffee_order/api/api.dart';
import 'package:coffee_order/dto/order.dart';
import 'package:coffee_order/dto/user.dart';
import 'package:coffee_order/util/snackbar_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dto/order_item.dart';
import '../dto/product.dart';

class ProductModel with ChangeNotifier {
  List<Product> _products = [];
  List<OrderItem> _orders = [];
  double _total = 0;
  bool _error = false;
  bool _loading = false;

  List<Product> get products => _products;

  set products(value) {
    _products = value;
    if (_products != null) {
      _orders = _products
          .map((p) => OrderItem(quantity: 0, subtotal: 0, product: p))
          .toList();
    }

    _updateTotal();
  }

  List<OrderItem> get orders => _orders;

  double get total => _total;

  bool get error => _error;

  bool get loading => _loading;

  ProductModel() {
    buscarProdutos();
  }

  Future<void> buscarProdutos() async {
    _loading = true;
    _error = false;
    notifyListeners();

    try {
      products = await Api().getCoffees();
    } catch(err) {
      log(err.toString());
      _error = true;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void _updateTotal() {
    _total = _orders.fold(0, (acc, item) => acc + item.subtotal);
    notifyListeners();
  }

  void addProduct(index) {
    _orders[index].quantity++;
    _orders[index].subtotal = _orders[index].quantity * _products[index].price;

    _updateTotal();
  }

  void removeProduct(index) {
    if (_orders[index].quantity > 0) {
      _orders[index].quantity--;
      _orders[index].subtotal =
          _orders[index].quantity * _products[index].price;

      _updateTotal();
    }
  }

  void checkout(BuildContext context, User user) async {
    _loading = true;
    try {
      if (orders.any((item) => item.quantity > 0)) {
        List<OrderItem> orderItems =
            _orders.where((item) => item.quantity > 0).toList();
        Order order = Order(user: user, items: orderItems);
        await Api().saveOrder(order);
        SnackBarUtils.showSnackBar(context, 'Pedido salvo com sucesso.', true);
      } else {
        SnackBarUtils.showSnackBar(context, 'Pedido vazio!', false);
      }
    } on Exception {
      SnackBarUtils.showSnackBar(context,
          'Ocorreu um erro ao salvar seu pedido. Tente novamente.', false);
    } finally {
      _loading = false;
    }
  }
}
