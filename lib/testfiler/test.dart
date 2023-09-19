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
  MyState state = MyState();

  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Förstasidan
class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsView(),
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyText(),
        ],
      ),
    );
  }
}

class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var name = context.watch<MyState>().name;
    var description = context.watch<MyState>().description;
    return Column(
      children: [
        Row(children: [Text(name)]),
        Row(children: [Text(description)]),
      ],
    );
  }
}

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Add item',
            ),
            onChanged: (text) {
              context.read<MyState>().setName(text);
            },
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Add description',
            ),
            onChanged: (text) {
              context.read<MyState>().setName(text);
            },
          ),
          FilledButton(
            onPressed: () {
              context.read<MyState>().setName;
              Navigator.pop(context);
            },
            child: Text('Skicka'),
          ),
        ],
      ),
    );
  }
}
