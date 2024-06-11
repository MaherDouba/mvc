class Note {
  final int id;
  final String title;
  final String note;
  final String color;

  Note({
    required this.id,
    required this.title,
    required this.note,
    required this.color,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      note: map['note'],
      color: map['color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'color': color,
    };
  }
}
