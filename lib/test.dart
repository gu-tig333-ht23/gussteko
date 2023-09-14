import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyState extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
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

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counter = context.watch<MyState>().counter;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtherView(),
                ),
              );
            },
          ),
        ],
        centerTitle: true,
        title: const Text('Count me in'),
      ),
      body: Center(
        child: Text('Counter: $counter'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<MyState>().incrementCounter();
          },
          child: Icon(Icons.add)),
    );
  }
}

class OtherView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counter = context.watch<MyState>().counter;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Other View'),
      ),
      body: Center(
        child: Text('Counter: $counter'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<MyState>().incrementCounter();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
