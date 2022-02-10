import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/providers/notes.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  Note _note = Note(
    id: null,
    title: '',
    note: '',
    updatedAt: null,
    createdAt: null,
  );

  final _formKey = GlobalKey<FormState>();

  void submitNote() {
    _formKey.currentState.save();
    final now = DateTime.now();
    _note.copyWith(
      updatedAt: now,
      createdAt: now,
    );
    final notesProvider = Provider.of<Notes>(context, listen: false);
    notesProvider.addNote(_note);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: submitNote,
              child: Text('Simpan'),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Judul',
                    border: InputBorder.none,
                  ),
                  onSaved: (value) {
                    _note = _note.copyWith(title: value);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Tulis catatan disini...',
                    border: InputBorder.none,
                  ),
                  onSaved: (value) {
                    _note = _note.copyWith(note: value);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
