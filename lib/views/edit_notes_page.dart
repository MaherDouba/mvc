import 'package:flutter/material.dart';
import '../controllers/notes_controller.dart';
import '../models/note_model.dart';

class EditNotesPage extends StatefulWidget {
  @override
  State<EditNotesPage> createState() => _EditNotesPageState();
}

class _EditNotesPageState extends State<EditNotesPage> {
  final _formKey = GlobalKey<FormState>();
  final NotesController notesController = NotesController();
  late bool useDatabase;
  late Note note;
  late TextEditingController titleController;
  late TextEditingController noteController;
  late TextEditingController colorController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    note = args['note'];
    useDatabase = args['useDatabase'];
    titleController = TextEditingController(text: note.title);
    noteController = TextEditingController(text: note.note);
    colorController = TextEditingController(text: note.color);
  }

  void onUpdateNote() async {
    if (_formKey.currentState!.validate()) {
      Note updatedNote = Note(
        id: note.id,
        title: titleController.text,
        note: noteController.text,
        color: colorController.text,
      );
      await notesController.updateNote(updatedNote, useDatabase);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Title cannot be empty' : null,
              ),
              TextFormField(
                controller: noteController,
                decoration: InputDecoration(labelText: 'Note'),
                validator: (value) => value!.isEmpty ? 'Note cannot be empty' : null,
              ),
              TextFormField(
                controller: colorController,
                decoration: InputDecoration(labelText: 'Color'),
                validator: (value) => value!.isEmpty ? 'Color cannot be empty' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: onUpdateNote,
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
