import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './api.dart';
import './AddNoteView.dart';
import './NoteWidget.dart';

//För att kunna toggla filter
enum Filter {
  all,
  completed,
  incomplete,
}

class MyState extends ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  Filter _filter = Filter.all;
  Filter get filter => _filter;

  set filter(Filter value) {
    _filter = value;
    notifyListeners();
  }

  void fetchNotes() async {
    var notes = await getNotes();
    _notes = notes;
    notifyListeners();
  }
}

void main() {
  MyState state = MyState();
  state.fetchNotes();

  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    var notes = context.watch<MyState>().notes;
    var state = context.watch<MyState>();

// Filterfunktionalitet

    var filteredNotes = notes.where((note) {
      if (state.filter == Filter.all) {
        return true;
      } else if (state.filter == Filter.completed) {
        return note.done;
      } else {
        return !note.done;
      }
    }).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todo List'),
        actions: [
          PopupMenuButton<Filter>(
            onSelected: (filter) {
              state.filter = filter;
            },
//Filterfunktionalitet
            itemBuilder: (BuildContext context) {
              return Filter.values.map(
                (filter) {
                  return PopupMenuItem<Filter>(
                    value: filter,
                    child: Text(filter.toString().split('.').last),
                  );
                },
              ).toList();
            },
          ),
        ],
      ),

//Skapar listan med alla notes
      body: ListView(
        children: filteredNotes.map((note) => NoteWidget(note)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNoteView(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
