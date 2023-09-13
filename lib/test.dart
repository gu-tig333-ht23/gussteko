import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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

class MyHome extends StatefulWidget {
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtherView(counter, (value) {
                    setState(() {
                      counter = value;
                    });
                  }),
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
            setState(() {
              counter++;
            });
          },
          child: Icon(Icons.add)),
    );
  }
}

class OtherView extends StatefulWidget {
  int counter = 0;

  void Function(int) onChange = (p0) {};

  OtherView(this.counter, this.onChange);

  @override
  State<OtherView> createState() => _OtherViewState();
}

class _OtherViewState extends State<OtherView> {
  int counter = 0;

  @override
  void initState() {
    super.initState();

    counter = widget.counter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Other View'),
      ),
      body: Center(
        child: Text('Counter: $widget.counter'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++;
          });
          widget.onChange(counter);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
