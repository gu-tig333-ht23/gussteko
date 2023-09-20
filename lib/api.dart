import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = '36cfd381-9237-476e-ae2f-05ac73116424';
const String endPoint = 'https://todoapp-api.apps.k8s.gu.se';

class Note {
  final String? id;
  final String title;
  bool done;

  Note(this.id, this.title, this.done);

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      json['id'],
      json['title'],
      json['done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'done': done,
    };
  }
}

Future<List<Note>> getNotes() async {
  http.Response response =
      await http.get(Uri.parse('$endPoint/todos?key=$apiKey'));
  String body = response.body;
  List<dynamic> jsonResponse = jsonDecode(body);
  return jsonResponse.map((json) => Note.fromJson(json)).toList();
}

Future<void> addNote(Note note) async {
  await http.post(
    Uri.parse('$endPoint/todos?key=$apiKey'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(note.toJson()),
  );
}

Future<void> switchDone(Note note) async {
  String id = note.id!;
  note.done = !note.done;
  await http.put(
    Uri.parse('$endPoint/todos/$id?key=$apiKey'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(note.toJson()),
  );
}

Future<void> deleteNote(Note note) async {
  String id = note.id!;
  await http.delete(
    Uri.parse('$endPoint/todos/$id?key=36cfd381-9237-476e-ae2f-05ac73116424'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(note.toJson()),
  );
}
