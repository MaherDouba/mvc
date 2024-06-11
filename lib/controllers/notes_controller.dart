import '../models/note_model.dart';
import '../repositories/notes_repository.dart';

class NotesController {
  final NotesRepository notesRepository = NotesRepository();

  Future<List<Note>> getNotes(bool fromDatabase) async {
    return await notesRepository.getNotes(fromDatabase);
  }

  Future<void> addNote(Note note, bool toDatabase) async {
    await notesRepository.addNote(note, toDatabase);
  }

  Future<void> updateNote(Note note, bool toDatabase) async {
    await notesRepository.updateNote(note, toDatabase);
  }

  Future<void> deleteNoteById(int id, bool fromDatabase) async {
    await notesRepository.deleteNoteById(id, fromDatabase);
  }
}
