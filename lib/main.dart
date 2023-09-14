import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyState extends ChangeNotifier {
  String _name = '';
  String _description = '';
  bool _done = false;

  String get name => _name;
  String get description => _description;
  bool get done => _done;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void setDone(bool done) {
    _done = done;
    notifyListeners();
  }
}

void main() {
  runApp(TodoApp());
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
// och en knapp för att byta sida
class ListPage extends StatelessWidget {
  ListPage({super.key, required this.title});
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
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(child: Text('Alphabetical')),
                PopupMenuItem(child: Text('Done')),
                PopupMenuItem(child: Text('Not Done')),
              ];
            },
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TodoListCreator(items[index]);
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
  TodoListCreator(this.item, {super.key});

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
                ])),
            Padding(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  //color: Colors.red,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    print('Delete');
                  },
                )),
          ]),
    );
  }
}

// Sida 2 där man fyller i items
class AddPage extends StatelessWidget {
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
                onChanged: (text) {
                  context.read<MyState>().setName(text);
                },
              ),
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    );
  }
}
