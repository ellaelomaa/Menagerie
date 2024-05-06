import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lists/database/models/item_model.dart';
import 'package:lists/providers/item_provider.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatelessWidget {
  final ItemModel note;
  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    DateTime dtAdded = DateTime.parse(note.added);
    final f = DateFormat("dd.M.yyyy");
    String dtFormatted = f.format(dtAdded);

    return Consumer<NoteProvider>(
      builder: (context, provider, child) => SizedBox(
        width: double.infinity,
        child: Card(
          child: ListTile(
            title: Text(note.title),
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
                    provider.deleteItem(note.id!);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
