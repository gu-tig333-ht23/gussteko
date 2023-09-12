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

class ListPage extends StatelessWidget {
  const ListPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.check_box_outline_blank),
              title: Text('Klippa gräset'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.check_box_outline_blank),
              title: Text('Köpa snus'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.check_box_outline_blank),
              title: Text('Deklarera'),
              onTap: () {},
            ),
          ],
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPage()),
            );
          },
          child: const Icon(Icons.add),
        ));
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
          child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(), hintText: 'Enter your todo item'),
      )),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Add item to your list'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


/*

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Add Item'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
          ],
        ),
        body: Center(
            
            child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Enter your todo item'),
        )),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back'),
        ));
  }
}

*/