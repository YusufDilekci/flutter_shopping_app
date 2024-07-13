import 'package:flutter/material.dart';
import 'package:shopping_app/model/item.dart';
import 'package:shopping_app/screens/new_item_screen.dart';

class GroceryScreen extends StatefulWidget{
  const GroceryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GroceryScreenState();
  }

}

class _GroceryScreenState extends State<GroceryScreen>{
  final List<Item> _groceryItems = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<Item>(
      MaterialPageRoute(
        builder: (ctx) => const NewItemScreen(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _deleteItem(int index){
    setState(() {
      _groceryItems.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    final Widget content;

    if(_groceryItems.isEmpty){
      content = const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sepetiniz hiçbir ürün bulunmamaktadır')
        ],),
      );
    }
    else{
      content =  ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(_groceryItems[index].name),
          leading: Container(
            width: 24,
            height: 24,
            color: _groceryItems[index].category.color,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_groceryItems[index].quantity.toString()),
              IconButton(
                onPressed: () => _deleteItem(index),
                icon: const Icon(Icons.delete),
              ),
            ],
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