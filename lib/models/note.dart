class Note {
  final String id;
  String title;
  String body;

  Note({required this.id, required this.title, required this.body});

  Note copyWith({String? title, String? body}) =>
      Note(id: id, title: title ?? this.title, body: body ?? this.body);

  // Новый: для чтения из Firestore
  factory Note.fromMap(Map<String, dynamic> map, String id) {
    return Note(id: id, title: map['title'] ?? '', body: map['body'] ?? '');
  }

  // Новый: для записи в Firestore
  Map<String, dynamic> toMap() {
    return {'title': title, 'body': body};
  }
}
