import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/api.dart';
import 'package:template/main.dart';

class AddNoteView extends StatefulWidget {
  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  final TextEditingController titleController = TextEditingController();

  String noTitleWarning = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add Item'),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
//Varningstext om man försöker lägga till en tom note
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(noTitleWarning, style: TextStyle(fontSize: 15)),
            ),

//Textfält för att skriva in sin note
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Item Name',
              ),
            ),
            Padding(
//Knapp för att lägga till sin note
              padding: const EdgeInsets.all(15.0),
              child: FilledButton(
                onPressed: () async {
                  var title = titleController.text;
                  bool done = false;

//En note skapas bara om fältet för titeln inte är tomt
                  if (title != '') {
                    Note note = Note(null, title, done);
                    await addNote(note);
                    noTitleWarning = '';
                    context.read<MyState>().fetchNotes();
                    Navigator.pop(context);

//Om ingen titel skrivs in visas en varningstext
                  } else {
                    setState(
                      () {
                        noTitleWarning = 'Please enter a title';
                      },
                    );
                  }
                },
                child: Text('Add note'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
