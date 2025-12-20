class Note {
  final String id;
  String title;
  String body;

  Note({required this.id, required this.title, required this.body});

  Note copyWith({String? title, String? body}) =>
      Note(id: id, title: title ?? this.title, body: body ?? this.body);

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'body': body};
  }
}
