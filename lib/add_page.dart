import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String itemName = '';
    String itemDescription = '';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add Item'),
        actions: [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Item Name',
                ),
                onChanged: (text) {
                  itemName = text;
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Item Description',
                ),
                onChanged: (text) {
                  itemDescription = text;
                },
              ),
            ),
            SizedBox(height: 20),
            // Knapp som lägger till nya item i listan
            // Om man inte namger itemet så händer inget men man kan skippa description
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (itemName != '') {
                    TodoItem newItem =
                        TodoItem(itemName, itemDescription, false);
                    context.read<MyState>().addItem(newItem);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Item'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
