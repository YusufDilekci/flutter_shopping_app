import 'package:shopping_app/data/categories.dart';
import 'package:shopping_app/model/category.dart';

class Item{
  const Item({required this.id, required this.name, required this.quantity, required this.category});

  final String id;
  final String name;
  final int quantity;
  final Category category;

  factory Item.fromJson(Map<String, dynamic> json, String key) {
    final category = categories.entries.firstWhere((cat) => cat.value.title == json['category']).value;

    return Item(
      id: key,
      name: json['name'],
      quantity: json['quantity'],
      category: category,
    );
  }
  
}