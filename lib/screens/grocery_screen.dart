import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_app/model/item.dart';
import 'package:shopping_app/screens/new_item_screen.dart';
import 'package:http/http.dart' as http;

class GroceryScreen extends StatefulWidget{
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() {
    return _GroceryScreenState();
  }

}

class _GroceryScreenState extends State<GroceryScreen>{
  List<Item> _groceryItems = [];
  
  @override
  void initState() {
    super.initState();
    _getItems();
  }
  
  void _getItems() async{
    final Uri url = Uri.https('flutter-shopping-f4696-default-rtdb.firebaseio.com', 'shopping_list.json');

    final List<Item> _items = [];
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;
    data.forEach((key, value) {
      _items.add(Item.fromJson(value, key));
    });
    setState(() {
      _groceryItems = _items;
    });    
  }
  
  void _addItem() async{
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewItemScreen(),
      ),
    );

    _getItems();
  }

  void _deleteItem(int index) async{
    final Uri url = Uri.https('flutter-shopping-f4696-default-rtdb.firebaseio.com', 'shopping_list/${_groceryItems[index].id}.json');
    final response = await http.delete(url);
    
    if (response.statusCode == 200) {
      setState(() {
        _groceryItems.removeAt(index);
      });
    } 

  }
  @override
  Widget build(BuildContext context) {
    final Widget content;

    if(_groceryItems.isEmpty){
      content = const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sepetinizde hiçbir ürün bulunmamaktadır')
        ],),
      );
    }
    else{
      content =  ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) => _deleteItem(index),
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing:Text(_groceryItems[index].quantity.toString()),
          ),
        ),

        );
    }

    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () => _addItem(), 
            icon: const Icon(Icons.add)
            ),
        ],
      ),
      body: content,        
    );
    


  }

}