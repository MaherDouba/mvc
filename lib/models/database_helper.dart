import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note_model.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initializeDb();
    }
    return _db;
  }

  Future<Database> _initializeDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'notes.db');
    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 1);
    return mydb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY,
        title TEXT,
        note TEXT,
        color TEXT
      )
    ''');
  }

  Future<List<Note>> getNotes() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient!.query('notes');
    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        title: maps[i]['title'],
        note: maps[i]['note'],
        color: maps[i]['color'],
      );
    });
  }

  Future<void> addNote(Note note) async {
    var dbClient = await db;
    await dbClient!.insert('notes', note.toMap());
  }

  Future<void> updateNote(Note note) async {
    var dbClient = await db;
    await dbClient!.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<void> deleteNoteById(int id) async {
    var dbClient = await db;
    await dbClient!.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
