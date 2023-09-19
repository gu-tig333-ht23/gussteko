import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/main.dart';

class TodoListCreator extends StatelessWidget {
  final TodoItem item;
  final List<TodoItem> items;

  TodoListCreator(this.item, this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    var notes = context.watch<MyState>().notes;

    // Olika textstilar för att överstryka items som är klara
    TextStyle nameTextStyle;
    TextStyle descTextStyle;

    TextStyle nameDoneTextStyle =
        TextStyle(fontSize: 20, decoration: TextDecoration.lineThrough);

    TextStyle nameNotDoneTextStyle = TextStyle(
      fontSize: 20,
    );

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
