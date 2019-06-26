import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String imagePath;

  Product({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.imagePath,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      imagePath: json['imagePath'],
    );
  }
}
