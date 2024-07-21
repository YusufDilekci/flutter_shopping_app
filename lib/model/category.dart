import 'package:flutter/material.dart';

enum Categories{
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}

class Category{
  const Category(this.title, this.color);

  final String title;
  final Color color;

    factory Category.fromJson(Map<String, dynamic> json) {
      return Category(
        json['title'],
        Color(json['color']),
      );
  }
}