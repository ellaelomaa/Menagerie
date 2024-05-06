// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:lists/database/models/folder_model.dart';
import 'package:lists/providers/folder_provider.dart';
import 'package:provider/provider.dart';

class NewFolderForm extends StatelessWidget {
  NewFolderForm({super.key});
  final _folderNameController = TextEditingController();
  late List<DropdownMenuItem<String>> list;

  @override
  Widget build(BuildContext context) {
    final folderProvider = Provider.of<FolderProvider>(context, listen: false);
    return Scaffold(
      body: AlertDialog(
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await folderProvider.addFolder(FolderModel(
                  title: _folderNameController.text,
                  added: DateTime.now().toString()));
              _folderNameController.clear();
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
        title: Text("Add a new folder"),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _folderNameController,
                decoration: InputDecoration(
                    hintText: "Write folder name", labelText: "Title"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
