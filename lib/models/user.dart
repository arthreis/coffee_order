import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(includeIfNull: false, name: '_id')
  final String id;
  final String name;
  final String email;

  User({
    this.id,
    @required this.name,
    @required this.email
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
