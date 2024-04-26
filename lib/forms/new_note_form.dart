import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lists/assets/ui_components/app_bar.dart';
import 'package:lists/assets/ui_components/folder_dropdown.dart';
import 'package:lists/database/db_helper.dart';
import 'package:lists/database/models/folder_model.dart';
import 'package:lists/database/models/note_model.dart';

class NewNoteForm extends StatefulWidget {
  const NewNoteForm({super.key});

  @override
  State<NewNoteForm> createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();
  int currentFolderId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Add a new note"),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            children: <Widget>[
              TextFormField(
                key: const Key("title"),
                controller: _title,
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                },
              ),
              const SizedBox(
                height: 4,
              ),
              FoldersDropdown(
                onClicked: (id) {
                  currentFolderId = id;
                  debugPrint("Notes");
                  debugPrint(
                    currentFolderId.toString(),
                  );
                },
              ),
              Expanded(
                child: TextField(
                  maxLines: null,
                  autofocus: true,
                  key: const Key("content"),
                  controller: _content,
                  decoration: const InputDecoration(
                    label: Text("Write your note!"),
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              ElevatedButton(
                key: const Key("save"),
                onPressed: () {
                  DatabaseHelper.instance.addNote(
                    NoteModel(
                        name: _title.text,
                        folderId: currentFolderId,
                        added: DateTime.now().toString(),
                        content: _content.text),
                  );
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
