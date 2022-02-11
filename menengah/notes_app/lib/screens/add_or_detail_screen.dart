import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/providers/notes.dart';
import 'package:provider/provider.dart';

class AddOrDetailScreen extends StatefulWidget {
  static const routeName = '/addOrDetailScreen';
  @override
  _AddOrDetailScreenState createState() => _AddOrDetailScreenState();
}

class _AddOrDetailScreenState extends State<AddOrDetailScreen> {
  Note _note = Note(
    id: null,
    title: '',
    note: '',
    updatedAt: null,
    createdAt: null,
  );

  bool init = true;

  final _formKey = GlobalKey<FormState>();

  void submitNote() {
    _formKey.currentState.save();
    final now = DateTime.now();
    _note = _note.copyWith(
      updatedAt: now,
      createdAt: now,
    );
    final notesProvider = Provider.of<Notes>(context, listen: false);
    if (_note.id == null) {
      notesProvider.addNote(_note);
    } else {
      notesProvider.updateNote(_note);
    }
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (init) {
      String id = ModalRoute.of(context).settings.arguments as String;
      if (id != null) {
        _note = Provider.of<Notes>(context).getNote(id);
      }
      init = false;
    }
    super.didChangeDependencies();
  }

  String _convertDate(DateTime dateTime) {
    int diff = DateTime.now().difference(dateTime).inDays;
    if (diff > 0) {
      return DateFormat('dd-MM-yyyy').format(dateTime);
    }

    return DateFormat('hh:mm').format(dateTime);
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
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              padding: EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _note.title,
                        decoration: InputDecoration(
                          hintText: 'Judul',
                          border: InputBorder.none,
                        ),
                        onSaved: (value) {
                          _note = _note.copyWith(title: value);
                        },
                      ),
                      TextFormField(
                        initialValue: _note.note,
                        decoration: InputDecoration(
                          hintText: 'Tulis catatan disini...',
                          border: InputBorder.none,
                        ),
                        onSaved: (value) {
                          _note = _note.copyWith(note: value);
                        },
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_note.updatedAt != null)
              Positioned(
                bottom: 10,
                right: 10,
                child: Text(
                  'Terakhir diubah ${_convertDate(_note.updatedAt)}',
                ),
              ),
          ],
        ));
  }
}
