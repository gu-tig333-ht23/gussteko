import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyState extends ChangeNotifier {
  String _name = '';
  String _description = '';
  final List<TodoItem> _items = [
    TodoItem('This is an example', 'Examples looks like this'),
    TodoItem('To complete an item', 'Tap the checkbox to the left'),
    TodoItem('To remove an item', 'Tap the bin to the right'),
    TodoItem('To add a new item', 'Tap the button on your lower right'),
  ];
  bool _done = false;

  String get name => _name;
  String get description => _description;
  List<TodoItem> get items => _items;
  bool get done => _done;

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

  void setDone(bool done) {
    _done = done;
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

//Klassen TodoItem för varje elemetn i todo-listan
class TodoItem {
  String name;
  String description;
  bool done = false;

  TodoItem(this.name, this.description);
}

//Förstasidan där listan visas, builder för listan
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
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
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
                MaterialPageRoute(builder: (context) => AddPage()),
              );
            },
            child: Text('Add Item')
            //child: const Icon(Icons.add),
            ),
      ),
    );
  }
}

// Skapar listan och listelement av todo:er
class TodoListCreator extends StatelessWidget {
  final TodoItem item;
  final List<TodoItem> items;

  TodoListCreator(this.item, this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
              icon: Icon(Icons.check_box_outline_blank),
              onPressed: () {
                print('Checked');
              },
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(item.description),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              //color: Colors.red,
              icon: Icon(Icons.delete),
              onPressed: () {
                int currentIndex = items.indexOf(item);
                context.read<MyState>().deleteItem(currentIndex);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Sida 2 där man fyller i items
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
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (itemName != '') {
                    TodoItem newItem = TodoItem(itemName, itemDescription);
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
