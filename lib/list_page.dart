import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/add_page.dart';
import 'package:template/list_creator.dart';
import 'package:template/main.dart';

class ListPage extends StatelessWidget {
  ListPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    List<TodoItem> items = context.watch<MyState>().items;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todo List'),
        actions: <Widget>[
          //Knappen för att sortera OBS fungerar ej ännu
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(child: Text('All')),
                PopupMenuItem(child: Text('Done')),
                PopupMenuItem(child: Text('Not Done')),
              ];
            },
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TodoListCreator(items[index], items);
        },
        itemCount: items.length,
      ),
      floatingActionButton: Container(
        height: 50,
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPage(),
                ),
              );
            },
            child: Text('Add Item')),
      ),
    );
  }
}
