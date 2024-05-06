import 'package:flutter/material.dart';
import 'package:menagerie_provider/assets/ui_components/app_bar.dart';
import 'package:menagerie_provider/assets/ui_components/folder_dropdown.dart';
import 'package:menagerie_provider/database/db_helper.dart';
import 'package:menagerie_provider/database/models/folder_model.dart';
import 'package:menagerie_provider/database/models/item_model.dart';
import 'package:menagerie_provider/providers/folder_provider.dart';
import 'package:menagerie_provider/providers/item_provider.dart';
import 'package:provider/provider.dart';

class NewNoteForm extends StatelessWidget {
  NewNoteForm({super.key});
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();
  final boxHeight = 4.0;
  int currentFolderId = 1;

  @override
  Widget build(BuildContext context) {
    final folderProvider = Provider.of<FolderProvider>(context, listen: false);
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
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
              const FoldersDropdown(),
              Expanded(
                  child: TextField(
                maxLines: null,
                autofocus: true,
                key: const Key("content"),
                controller: _content,
                decoration: const InputDecoration(
                  label: Text("Write your note!"),
                ),
              )),
              ElevatedButton(
                key: const Key("save"),
                onPressed: () async {
                  await noteProvider.addItem(
                    ItemModel(
                        title: _title.text,
                        added: DateTime.now().toString(),
                        folderId: folderProvider.selectedFolder,
                        type: "note",
                        content: _content.text),
                  );
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
