import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/api.dart';
import 'main.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descController = TextEditingController();

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
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Item Name',
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              child: TextField(
                controller: descController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Item Description',
                ),
              ),
            ),
            SizedBox(height: 20),

            // Knapp som lägger till nya item i listan
            // Om man inte namger itemet så händer inget men man kan skippa description
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  var itemName = nameController.text;
                  var itemDescription = descController.text;
                  if (itemName != '') {
                    TodoItem newItem =
                        TodoItem(itemName, itemDescription, false);
                    context.read<MyState>().addItem(newItem);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Item'),
              ),
            ),
            Container(
              height: 50,
              child: FilledButton(
                  onPressed: () {
                    getNotes();
                  },
                  child: Text('Get Notes')),
            )
          ],
        ),
      ),
    );
  }
}
