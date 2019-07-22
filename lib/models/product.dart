import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(nullable: false)
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

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
