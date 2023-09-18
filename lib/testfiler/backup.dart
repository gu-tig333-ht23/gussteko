import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

// Skapar listan och listelement av todo:er
class TodoListCreator extends StatelessWidget {
  final TodoItem item;
  final List<TodoItem> items;

  TodoListCreator(this.item, this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    // Olika textstilar för att överstryka items som är klara
    TextStyle nameTextStyle;
    TextStyle descTextStyle;
    TextStyle nameDoneTextStyle =
        TextStyle(fontSize: 20, decoration: TextDecoration.lineThrough);

    TextStyle nameNotDoneTextStyle = TextStyle(fontSize: 20);

    TextStyle descDoneTextStyle =
        TextStyle(decoration: TextDecoration.lineThrough);

    TextStyle descNotDoneTextStyle = TextStyle();

    if (item.done == true) {
      nameTextStyle = nameDoneTextStyle;
      descTextStyle = descDoneTextStyle;
    } else {
      nameTextStyle = nameNotDoneTextStyle;
      descTextStyle = descNotDoneTextStyle;
    }

// Skapandet av varje listelement/todo-items
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: CheckBox(item, items),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.name, style: nameTextStyle),
                Text(item.description, style: descTextStyle),
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

// Checkbox modell för att byta mellan klar och inte klar
class CheckBox extends StatelessWidget {
  final TodoItem item;
  final List<TodoItem> items;

  CheckBox(this.item, this.items, {Key? key});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.black,
      activeColor: Colors.white,
      value: item.done,
      onChanged: (bool? value) {
        int currentIndex = items.indexOf(item);
        context.read<MyState>().setDone(currentIndex, value ?? false);
      },
    );
  }
}

// Sida 2 där man fyller i nya items till todo-listan
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
