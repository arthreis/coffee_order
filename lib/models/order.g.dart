// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      orderItems: (json['orderItems'] as List)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList());
}

Map<String, dynamic> _$OrderToJson(Order instance) =>
    <String, dynamic>{'user': instance.user, 'orderItems': instance.orderItems};
