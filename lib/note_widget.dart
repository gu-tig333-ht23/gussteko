import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/Note.dart';
import 'package:template/api.dart';
import 'package:template/main.dart';

class NoteWidget extends StatelessWidget {
  final Note note;

  NoteWidget(this.note);

  @override
  Widget build(BuildContext context) {
// Två olika textstilar beroende på om noten är klar eller inte,
// skapar en överstruken text om noten är klarmarkerad
    TextStyle nameTextStyle;
    TextStyle nameDoneTextStyle = const TextStyle(
      fontSize: 20,
      decoration: TextDecoration.lineThrough,
    );
    TextStyle nameNotDoneTextStyle = const TextStyle(
      fontSize: 20,
    );

    if (note.done == true) {
      nameTextStyle = nameDoneTextStyle;
    } else {
      nameTextStyle = nameNotDoneTextStyle;
    }

    return ListTile(

// Checkboxen som byter mellan done och not done en note
        leading: Checkbox(
          checkColor: Colors.black,
          activeColor: Colors.white,
          value: note.done,
          onChanged: (value) async {
            await switchDone(note);
            context.read<MyState>().fetchNotes();
          },
        ),

// Klickar man på själva noten byter den också mellan done och not done
        onTap: () async {
          await switchDone(note);
          context.read<MyState>().fetchNotes();
        },

// Själva noten med text och en deleteknapp
        title: Text(note.title, style: nameTextStyle),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () async {
            await deleteNote(note);
            context.read<MyState>().fetchNotes();
          },
        ));
  }
}
