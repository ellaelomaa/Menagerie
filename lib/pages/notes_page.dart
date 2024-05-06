// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lists/assets/ui_components/app_bar.dart';
import 'package:lists/assets/ui_components/fab.dart';
import 'package:lists/assets/ui_components/note_card.dart';
import 'package:lists/providers/item_provider.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Notes"),
      floatingActionButton: FAB(),
      body: Consumer<NoteProvider>(
        builder: (context, provider, child) {
          var notes = provider.notes;
          if (notes.isEmpty) {
            return Center(
              child: Text(notes.length.toString()),
            );
          } else {
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                var note = notes[index];
                return NoteCard(note: note);
              },
            );
          }
        },
      ),
    );
  }
}
