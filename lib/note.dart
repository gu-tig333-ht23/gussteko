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
