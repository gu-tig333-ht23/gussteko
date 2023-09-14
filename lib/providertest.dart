import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyState extends ChangeNotifier {
  Color _color = Colors.black;

  Color get color => _color;

  void setColor(Color color) {
    _color = color;
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
          MyCircle(),
          MyCircle(),
          MyCircle(),
          MyCircle(),
          MyCircle(),
        ],
      ),
    );
  }
}

class MyCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var color = context.watch<MyState>().color;
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
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
          FilledButton(
            onPressed: () {
              context.read<MyState>().setColor(Colors.blue);
              Navigator.pop(context);
            },
            child: Text('blue'),
          ),
          FilledButton(
            onPressed: () {
              context.read<MyState>().setColor(Colors.red);
              Navigator.pop(context);
            },
            child: Text('red'),
          ),
          FilledButton(
            onPressed: () {
              context.read<MyState>().setColor(Colors.black);
              Navigator.pop(context);
            },
            child: Text('black'),
          ),
        ],
      ),
    );
  }
}
