import 'package:flutter/material.dart';

class Product {
  Product({
    @required this.name,
    @required this.value,
  });

  final String name;
  final double value;
}