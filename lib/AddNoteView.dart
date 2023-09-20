import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/api.dart';
import 'package:template/main.dart';

class AddNoteView extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();

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
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Item Name',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FilledButton(
                onPressed: () async {
                  var title = titleController.text;
                  bool done = false;
                  if (title != '') {
                    Note note = Note(null, title, done);
                    await addNote(note);
                    context.read<MyState>().fetchNotes();
                    Navigator.pop(context);
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
