import 'dart:convert';

import 'package:notes_app/models/note.dart';
import 'package:http/http.dart' as http;

class NoteApi {
  Future<List<Note>> getAllNote() async {
    final uri = Uri.parse(
      'https://notes-62c64-default-rtdb.asia-southeast1.firebasedatabase.app/notes.json',
    );
    final response = await http.get(uri);
    final results = json.decode(response.body) as Map<String, dynamic>;
    List<Note> notes = [];
    results.forEach((key, value) {
      notes.add(
        Note(
          id: key,
          title: value['title'],
          note: value['note'],
          updatedAt: DateTime.parse(value['updated_at']),
          createdAt: DateTime.parse(value['created_at']),
          isPinned: value['isPinned'],
        ),
      );
    });
    return notes;
  }
}
