import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/presentations/custom_icons_icons.dart';
import 'package:notes_app/providers/notes.dart';
import 'package:notes_app/screens/add_or_detail_screen.dart';
import 'package:provider/provider.dart';

class NoteItem extends StatefulWidget {
  final String id;
  NoteItem({
    @required this.id,
  });

  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<Notes>(context, listen: false);
    Note note = notesProvider.getNote(widget.id);
    return Dismissible(
      key: Key(note.id),
      onDismissed: (direction) {
        notesProvider.deleteNote(note.id);
      },
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          AddOrDetailScreen.routeName,
          arguments: note.id,
        ),
        child: GridTile(
          header: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                notesProvider.toggleIsPinned(note.id);
              },
              icon: Icon(
                  note.isPinned ? CustomIcons.pin : CustomIcons.pin_outline),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[800],
            ),
            child: Text(note.note),
            padding: EdgeInsets.all(12),
          ),
          footer: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: GridTileBar(
              title: Text(note.title),
              backgroundColor: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
