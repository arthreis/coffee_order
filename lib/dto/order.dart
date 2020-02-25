
import 'package:coffee_order/dto/user.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_item.dart';

part 'order.g.dart';

@JsonSerializable(nullable: false)
class Order {
  @JsonKey(toJson: _extractUserId)
  final User user;
  final List<OrderItem> items;

  Order({@required this.user, @required this.items});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

String _extractUserId(User user) => user.id;