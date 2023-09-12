import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ListPage(title: 'Todo Listpage'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoItem {
  final String name;
  final String description;

  TodoItem(this.name, this.description);
}

class ListPage extends StatelessWidget {
  const ListPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    List<TodoItem> items = [
      TodoItem('Klippa gräset', 'Trädgården och bakom skjulet'),
      TodoItem('Köpa snus', 'Två stockar lös till pappa'),
      TodoItem('Städa', 'Disk och tvätt innan sambon slutar'),
      TodoItem('Parkera om bilen', 'Städdag på gatan tordag 20/9'),
      TodoItem('Plugga', 'Gör modul 2 i flutterkursen'),
      TodoItem('Skriv arg lapp', 'Grannen spelar hög musik varje kväll'),
    ];
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Todo List'),
          actions: <Widget>[
            PopupMenuButton(itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(child: Text('Alphabetical')),
                PopupMenuItem(child: Text('Done')),
                PopupMenuItem(child: Text('Not Done')),
              ];
            })
          ],
        ),
        body: ListView(
            children: items
                .map((TodoItem) => _item(TodoItem.name, TodoItem.description))
                .toList()));
  }

  Widget _item(String name, String role) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
              icon: Icon(Icons.check_box_outline_blank),
              onPressed: () {},
            ),
          ),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(role),
              ])),
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                //color: Colors.red,
                icon: Icon(Icons.delete),
                onPressed: () {},
              )),
        ]);
  }
}

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add Item'),
        actions: [],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Add item',
                ),
              ),
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    );
  }
}
