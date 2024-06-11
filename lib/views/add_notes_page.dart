import 'package:flutter/material.dart';
import '../controllers/notes_controller.dart';
import '../models/note_model.dart';

class AddNotesPage extends StatefulWidget {
  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  final _formKey = GlobalKey<FormState>();
  final NotesController notesController = NotesController();
  late bool useDatabase;
  late TextEditingController titleController;
  late TextEditingController noteController;
  late TextEditingController colorController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    useDatabase = ModalRoute.of(context)?.settings.arguments as bool;
    titleController = TextEditingController();
    noteController = TextEditingController();
    colorController = TextEditingController();
  }

  void onSaveNote() async {
    if (_formKey.currentState!.validate()) {
      Note note = Note(
        id: DateTime.now().millisecondsSinceEpoch,
        title: titleController.text,
        note: noteController.text,
        color: colorController.text,
      );
      await notesController.addNote(note, useDatabase);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Note')),
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
                onPressed: onSaveNote,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
