import 'package:http/http.dart' as http;
import 'dart:convert';

//////////////// API KEY f2b712e9-f98a-45db-b7c6-64d7ebad4140

//   https://todoapp-api.apps.k8s.gu.se/

//   Todo API
// These are the end points for this API.

// A todo has the following format:

// {
//   "id": "ca3084de-4424-4421-98af-0ae9e2cb3ee5",
//   "title": "Must pack bags",
//   "done": false
// }

// When creating a Todo you should not submit the id.
// API key
// All requests requires an API key. An API key uniquely identifies your Todo list. You can get an API key by using the /register endpoint.

// GET /register
// Get your API key

// GET /todos?key=[YOUR API KEY]
// List todos.
// Will return an array of todos.

// POST /todos?key=[YOUR API KEY]
// Add todo.
// Takes a Todo as payload (body). Remember to set the Content-Type header to application/json.
// Will return the entire list of todos, including the added Todo, when successful.

// PUT /todos/:id?key=[YOUR API KEY]
// Update todo with :id
// Takes a Todo as payload (body), and updates title and done for the already existing Todo with id in URL.

// DELETE /todos/:id?key=[YOUR API KEY]
// Deletes a Todo with id in URL

const String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';
const String MyApiKey = 'f2b712e9-f98a-45db-b7c6-64d7ebad4140';

class Note {
  final String title;
  final String content;
  final String done;

  Note(this.title, this.content, this.done);

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      json['id'],
      json['title'],
      json['done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': title,
      'title': content,
      'done': done,
    };
  }
}

Future<List<Note>> getAPI() async {
  print('Making Request');
  http.Response response = await http.get(Uri.parse('$ENDPOINT/register'));
  String body = response.body;
  print(body);
  return [];
}

Future<List<Note>> getNotes() async {
  http.Response response =
      await http.get(Uri.parse('$ENDPOINT/get/todos?key=[$MyApiKey]'));
  String body = response.body;
  Map<String, dynamic> jsonResponse = jsonDecode(body);
  List notesJson = jsonResponse = jsonDecode(body);
  return notesJson.map((json) => Note.fromJson(json)).toList();
}

void addNote(Note note) async {
  await http.post(
    Uri.parse('$ENDPOINT/post/todos?key=[$MyApiKey]'),
    body: jsonEncode(note.toJson()),
  );
}
