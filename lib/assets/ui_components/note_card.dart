// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

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
    final noteProvider = Provider.of<ItemProvider>(context, listen: false);

    void deleteNote(BuildContext context, int id) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(
                  "Are you sure you want to delete the note? This cannot be undone."),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    noteProvider.deleteItem(id);
                    Navigator.pop(context);
                  },
                  child: Text("Delete"),
                ),
              ],
            );
          });
    }

    return Consumer<ItemProvider>(
      builder: (context, provider, child) => SizedBox(
        width: double.infinity,
        child: Card(
          child: GestureDetector(
            child: ListTile(
              leading: note.pinned == 1 ? Icon(Icons.favorite) : Icon(null),
              title: Text(note.title),
              subtitle: Text(note.pinned.toString()),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.favorite),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Pin")
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Edit")
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Delete")
                      ],
                    ),
                  ),
                ],
                offset: Offset(30, -10),
                onSelected: (value) {
                  if (value == 1) {
                    provider.markAsPinned(note);
                  }
                  if (value == 2) {}
                  if (value == 3) {
                    deleteNote(context, note.id!);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
