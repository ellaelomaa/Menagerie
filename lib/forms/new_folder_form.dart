import 'package:flutter/material.dart';
import 'package:lists/database/db_helper.dart';
import 'package:lists/database/models/folder_model.dart';

class FolderAlert extends StatelessWidget {
  FolderAlert({
    super.key,
    required TextEditingController folderNameController,
  }) : _folderNameController = folderNameController;

  final TextEditingController _folderNameController;
  late List<DropdownMenuItem<String>> list;

  updateDropdownmenu() {
    list = [];
    DatabaseHelper.instance.getFolders().then(
      (value) {
        value.map((map) {
          return getDropdownWidget(map);
        }).forEach(
          (element) {
            list.add(element);
          },
        );
      },
    );
  }

  DropdownMenuItem<String> getDropdownWidget(Folder folder) {
    return DropdownMenuItem<String>(
      value: folder.name,
      child: Text(folder.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            DatabaseHelper.instance.addFolder(
              Folder(
                  name: _folderNameController.text,
                  added: DateTime.now().toString()),
            );
            // setState(() {
            //   _folderNameController.clear();
            //   updateDropdownmenu();
            // });
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
                  hintText: "Write folder name", labelText: "Folder"),
            )
          ],
        ),
      ),
    );
  }
}

class NewFolderForm extends StatelessWidget {
  NewFolderForm({super.key});
  final _folderNameController = TextEditingController();
  late List<DropdownMenuItem<String>> list;

  _showFormDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                DatabaseHelper.instance.addFolder(
                  Folder(
                      name: _folderNameController.text,
                      added: DateTime.now().toString()),
                );
                _folderNameController.clear();
                updateDropdownmenu();
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
                      hintText: "Write folder name", labelText: "Folder"),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  updateDropdownmenu() {
    list = [];
    DatabaseHelper.instance.getFolders().then(
      (value) {
        value.map((map) {
          return getDropdownWidget(map);
        }).forEach(
          (element) {
            list.add(element);
          },
        );
      },
    );
  }

  DropdownMenuItem<String> getDropdownWidget(Folder folder) {
    return DropdownMenuItem<String>(
      value: folder.name,
      child: Text(folder.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            DatabaseHelper.instance.addFolder(
              Folder(
                  name: _folderNameController.text,
                  added: DateTime.now().toString()),
            );
            // setState(() {
            //   _folderNameController.clear();
            //   updateDropdownmenu();
            // });
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
                  hintText: "Write folder name", labelText: "Folder"),
            )
          ],
        ),
      ),
    );
  }
}
