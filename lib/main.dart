import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/list_page.dart';
import 'package:http/http.dart' as http;
import 'package:template/api.dart';

//////////////// API KEY f2b712e9-f98a-45db-b7c6-64d7ebad4140

//   https://todoapp-api.apps.k8s.gu.se/

//   Todo API
// These are the end points for this API.

// A todo has the following format:

// {
//   "id": "ca3084de-4424-4421-98af-0ae9e2cb3ee5",
//   "title": "Must pack bags",
//   "done": false
// }
// When creating a Todo you should not submit the id.
// API key
// All requests requires an API key. An API key uniquely identifies your Todo list. You can get an API key by using the /register endpoint.

// GET /register
// Get your API key

// GET /todos?key=[YOUR API KEY]
// List todos.

// Will return an array of todos.

// POST /todos?key=[YOUR API KEY]
// Add todo.

// Takes a Todo as payload (body). Remember to set the Content-Type header to application/json.

// Will return the entire list of todos, including the added Todo, when successful.

// PUT /todos/:id?key=[YOUR API KEY]
// Update todo with :id

// Takes a Todo as payload (body), and updates title and done for the already existing Todo with id in URL.

// DELETE /todos/:id?key=[YOUR API KEY]
// Deletes a Todo with id in URL

enum Filter { showAll, showDone, showNotDone }

// Klass med changenotifier, variabler och funktioner för todo-listan
class MyState extends ChangeNotifier {
  String _name = '';
  String _description = '';
  final bool _done = false;
  Filter _filter = Filter.showAll;
  List<Note> _notes = [];

  // Ger listan ett par exempel och en guide för nya användare
  final List<TodoItem> _items = [
    TodoItem('This is an example', 'Examples looks like this', false),
    TodoItem('To complete an item', 'Tap the checkbox to the left', false),
    TodoItem('To remove an item', 'Tap the bin to the right', false),
    TodoItem('To add a new item', 'Tap the button on your lower right', false),
  ];

  String get name => _name;
  String get description => _description;
  bool get done => _done;
  List<TodoItem> get items => _items;
  Filter get filter => _filter;
  List<Note> get notes => _notes;

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

  void setFilter(Filter option) {
    _filter = option;
    notifyListeners();
  }

  void fetchNotes() async {
    var notes = await getNotes();
    _notes = notes;
    notifyListeners();
  }
}

void main() {
  // MyState state = MyState();
  // state.fetchNotes();

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

