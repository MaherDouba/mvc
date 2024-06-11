import 'package:flutter/material.dart';
import '../controllers/notes_controller.dart';
import '../models/note_model.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  NotesController notesController = NotesController();

  List<Note> notes = [];
  bool loading = true;
  bool useDatabase = true;

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await notesController.getNotes(useDatabase);
    setState(() {
      notes = fetchedNotes;
      loading = false;
    });
  }

  void onDatabaseChoiceChanged(bool? value) {
    if (value != null) {
      setState(() {
        useDatabase = value;
        loading = true;
      });
      fetchNotes();
    }
  }

  void onAddNote() async {
    await Navigator.of(context).pushNamed('addnotes', arguments: useDatabase);
    fetchNotes();
  }

  void onEditNote(Note note) async {
    await Navigator.of(context).pushNamed('editnotes', arguments: {'note': note, 'useDatabase': useDatabase});
    fetchNotes();
  }

  void onDeleteNote(int id) async {
    await notesController.deleteNoteById(id, useDatabase);
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddNote,
        child: Icon(Icons.add),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                RadioListTile(
                  title: Text('Use Database'),
                  value: true,
                  groupValue: useDatabase,
                  onChanged: onDatabaseChoiceChanged,
                ),
                RadioListTile(
                  title: Text('Use Shared Preferences'),
                  value: false,
                  groupValue: useDatabase,
                  onChanged: onDatabaseChoiceChanged,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return ListTile(
                        title: Text(note.title),
                        subtitle: Text(note.note),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              color: Colors.blue,
                              icon: Icon(Icons.edit),
                              onPressed: () => onEditNote(note),
                            ),
                            IconButton(
                              color: Colors.red,
                              icon: Icon(Icons.delete),
                              onPressed: () => onDeleteNote(note.id),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
