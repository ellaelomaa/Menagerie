import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lists/database/db_helper.dart';
import 'package:lists/database/models/note_model.dart';
import 'package:intl/date_symbol_data_local.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    DateTime dtAdded = DateTime.parse(note.added);
    final f = new DateFormat("dd.M.yyyy");
    String dtFormatted = f.format(dtAdded);

    return Card(
      child: ListTile(
        title: Text(note.name),
        subtitle: Text(
          note.content ?? "",
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(dtFormatted),
            IconButton(
                onPressed: () {
                  DatabaseHelper.instance.removeItem("notes", note.id!);
                },
                icon: const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
