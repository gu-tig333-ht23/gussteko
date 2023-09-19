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
    Filter filterOption = context.watch<MyState>().filter;

    List<TodoItem> filteredItems = [];

    if (filterOption == Filter.showAll) {
      filteredItems = items;
    } else if (filterOption == Filter.showDone) {
      filteredItems = items.where((item) => item.done).toList();
    } else if (filterOption == Filter.showNotDone) {
      filteredItems = items.where((item) => !item.done).toList();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todo List'),
        actions: <Widget>[
          //Knappen för att sortera OBS fungerar ej ännu
          PopupMenuButton<Filter>(
            onSelected: (Filter option) {
              context.read<MyState>().setFilter(option);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<Filter>(
                  value: Filter.showAll,
                  child: Text('All'),
                ),
                PopupMenuItem<Filter>(
                  value: Filter.showDone,
                  child: Text('Done'),
                ),
                PopupMenuItem<Filter>(
                  value: Filter.showNotDone,
                  child: Text('Not Done'),
                ),
              ];
            },
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TodoListCreator(filteredItems[index], items);
        },
        itemCount: filteredItems.length,
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
