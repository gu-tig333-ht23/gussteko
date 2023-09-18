import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/list_page.dart';

// Klass med changenotifier, variabler och funktioner för todo-listan
class MyState extends ChangeNotifier {
  String _name = '';
  String _description = '';

  // Ger listan ett par exempel och en guide för nya användare
  final List<TodoItem> _items = [
    TodoItem('This is an example', 'Examples looks like this', false),
    TodoItem('To complete an item', 'Tap the checkbox to the left', false),
    TodoItem('To remove an item', 'Tap the bin to the right', false),
    TodoItem('To add a new item', 'Tap the button on your lower right', false),
  ];

  bool _done = false;
  String get name => _name;
  String get description => _description;
  List<TodoItem> get items => _items;
  bool get done => _done;

//funktioner
  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void addItem(TodoItem item) {
    _items.add(item);
    notifyListeners();
  }

  void setDone(int index, bool done) {
    _items[index].done = done;
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyState(),
      child: TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  TodoApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: ListPage(title: 'Todo Listpage'),
      debugShowCheckedModeBanner: false,
    );
  }
}

//Klassen TodoItem för varje element i todo-listan
class TodoItem {
  String name;
  String description;
  bool done = false;

  TodoItem(this.name, this.description, this.done);
}

// Skapar listan och listelement av todo:er

