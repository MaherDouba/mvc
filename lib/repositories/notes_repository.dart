import '../models/database_helper.dart';
import '../models/note_model.dart';
import 'shared_prefernces_helper.dart';

class NotesRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();

  Future<List<Note>> getNotes(bool fromDatabase) async {
    if (fromDatabase) {
      return await _dbHelper.getNotes();
    } else {
      return await _prefsHelper.getNotes();
    }
  }

  Future<void> addNote(Note note, bool toDatabase) async {
    if (toDatabase) {
      await _dbHelper.addNote(note);
    } else {
      await _prefsHelper.addNote(note);
    }
  }

  Future<void> updateNote(Note note, bool toDatabase) async {
    if (toDatabase) {
      await _dbHelper.updateNote(note);
    } else {
      await _prefsHelper.updateNote(note);
    }
  }

  Future<void> deleteNoteById(int id, bool fromDatabase) async {
    if (fromDatabase) {
      await _dbHelper.deleteNoteById(id);
    } else {
      await _prefsHelper.deleteNoteById(id);
    }
  }
}
