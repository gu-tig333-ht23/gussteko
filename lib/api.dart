import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:template/Note.dart';

const String apiKey = '36cfd381-9237-476e-ae2f-05ac73116424';
const String endPoint = 'https://todoapp-api.apps.k8s.gu.se';

//Funktion för att hämta alla notes
Future<List<Note>> getNotes() async {
  http.Response response =
      await http.get(Uri.parse('$endPoint/todos?key=$apiKey'));
  String body = response.body;
  List<dynamic> jsonResponse = jsonDecode(body);
  return jsonResponse.map((json) => Note.fromJson(json)).toList();
}

//Funktion för att lägga till en note
Future<void> addNote(Note note) async {
  await http.post(
    Uri.parse('$endPoint/todos?key=$apiKey'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(note.toJson()),
  );
}

//Uppdateringsfunktionen som egentligen bara byter mellan done och not done
Future<void> switchDone(Note note) async {
  String id = note.id!;
  note.done = !note.done;
  await http.put(
    Uri.parse('$endPoint/todos/$id?key=$apiKey'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(note.toJson()),
  );
}

//Funktion för att ta bort en note
Future<void> deleteNote(Note note) async {
  String id = note.id!;
  await http.delete(
    Uri.parse('$endPoint/todos/$id?key=$apiKey'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(note.toJson()),
  );
}
