import 'package:flutter/material.dart';
import 'package:notes_app/providers/notes.dart';
import 'package:notes_app/screens/add_or_detail_screen.dart';
import 'package:notes_app/widgets/notes_grid.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
      ),
      body: FutureBuilder(
        future: Provider.of<Notes>(context, listen: false).getAndSetNotes(),
        builder: (ctx, notesSnapshot) {
          if (notesSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return NotesGrid();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddOrDetailScreen.routeName);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow[700],
      ),
    );
  }
}
