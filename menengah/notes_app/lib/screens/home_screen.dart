import 'package:flutter/material.dart';
import 'package:notes_app/screens/add_or_detail_screen.dart';
import 'package:notes_app/widgets/notes_grid.dart';

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
      body: NotesGrid(),
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
