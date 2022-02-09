import 'package:flutter/material.dart';
import 'package:notes_app/presentations/custom_icons_icons.dart';

class NoteItem extends StatefulWidget {
  final String id;
  final String title;
  final String note;
  final bool isPinned;
  final Function(String id) toggleIsPinnedFn;

  NoteItem({
    @required this.id,
    @required this.title,
    @required this.note,
    @required this.isPinned,
    @required this.toggleIsPinnedFn,
  });

  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  bool _isPinned;

  @override
  Widget build(BuildContext context) {
    _isPinned = widget.isPinned;
    return GridTile(
      header: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () {
            widget.toggleIsPinnedFn(widget.id);
          },
          icon: Icon(_isPinned ? CustomIcons.pin : CustomIcons.pin_outline),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[800],
        ),
        child: Text(widget.note),
        padding: EdgeInsets.all(12),
      ),
      footer: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        child: GridTileBar(
          title: Text(widget.title),
          backgroundColor: Colors.black87,
        ),
      ),
    );
  }
}
